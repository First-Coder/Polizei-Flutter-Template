import 'dart:async';

import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../screens/widgets/layouts/responsive.dart' show Responsive;

/// A wrapper widget that attaches an *imperative* shadcn_flutter popover to a [Button].
///
/// ## Why does this exist?
/// shadcn_flutter opens popovers via `showPopover(...)` (imperative API).
/// Because `Button.onPressed` is `final`, we cannot "patch" the callback from an
/// extension or after the button has been created. Instead, we wrap the button
/// and listen to pointer interactions above it (press and/or hover).
///
/// ## Supported interaction modes
/// - **Press (tap/click):**
///   Opens the popover on pointer down.
///   Optionally calls the original `button.onPressed` afterwards.
///   This is also the required fallback on touch devices.
/// - **Hover (desktop/web):**
///   Opens after [hoverOpenDelay] to avoid accidental popovers when the pointer
///   passes over the trigger quickly.
///   Closes after [hoverCloseDelay] so users can move the pointer from the anchor
///   into the popover content (menu) without it collapsing.
///
/// ## Hover intent model (menu reachable + stays open)
/// The popover stays open while the pointer is over:
/// - the **anchor** (the wrapped button), OR
/// - the **popover content**
///
/// On leaving the anchor, we start a close timer. If the user moves into the
/// popover before the timer fires, we cancel the close timer.
/// When both are no longer hovered, the popover closes.
///
/// ## Overlay closing safety
/// shadcn_flutter's `closeOverlay(...)` requires a context that belongs to the
/// overlay. We therefore store the `overlayContext` passed to the `showPopover`
/// builder, and use it for closing. The stored context can become unmounted if
/// the popover is closed from within; we guard against double-close races.
class ButtonPopoverWrapper extends StatefulWidget {
  const ButtonPopoverWrapper({
    super.key,
    required this.anchor,
    required this.builder,
    required this.enablePress,
    required this.callOriginalOnPressed,
    required this.originalOnPressed,
    required this.enableHover,
    required this.hoverOpenDelay,
    required this.hoverCloseDelay,
    required this.placement,
    required this.offset,
  });

  /// The button that acts as the popover anchor (visual trigger).
  final Widget anchor;

  /// Builder for the popover content.
  ///
  /// The [BuildContext] passed to this builder is the overlay's context.
  /// If you close the overlay from inside the content, you must use that context.
  final WidgetBuilder builder;

  /// Enables press-to-open behavior.
  ///
  /// Note: even if disabled, touch devices will still use press as hover is not available.
  final bool enablePress;

  /// When true, the wrapper will call the original `button.onPressed` after opening the popover.
  final bool callOriginalOnPressed;

  /// Optional original press handler of the anchor.
  final VoidCallback? originalOnPressed;

  /// Enables hover-to-open behavior (only used on non-touch devices).
  final bool enableHover;

  /// Delay before opening on hover (reduces accidental opens).
  final Duration hoverOpenDelay;

  /// Delay before closing after hover exit (allows moving into the menu).
  final Duration hoverCloseDelay;

  /// Popover alignment relative to the anchor.
  final Alignment placement;

  /// Additional popover position offset.
  final Offset offset;

  @override
  State<ButtonPopoverWrapper> createState() => _ButtonPopoverWrapperState();
}

class _ButtonPopoverWrapperState extends State<ButtonPopoverWrapper> {
  /// Timer for delayed hover open.
  Timer? _openTimer;

  /// Timer for delayed hover close (hover intent).
  Timer? _closeTimer;

  /// Whether the pointer is currently hovering the anchor (button).
  bool _isAnchorHovering = false;

  /// Whether the pointer is currently hovering the popover content.
  bool _isPopoverHovering = false;

  /// Prevents double-close races (e.g. popover closed by click + hover exit).
  bool _isClosing = false;

  /// Overlay context captured from `showPopover`'s builder.
  ///
  /// We need this exact context for `closeOverlay(...)`.
  BuildContext? popoverContext;

  /// True when either anchor or popover is being hovered.
  bool get _shouldStayOpen => _isAnchorHovering || _isPopoverHovering;

  void _cancelOpenTimer() {
    _openTimer?.cancel();
    _openTimer = null;
  }

  void _cancelCloseTimer() {
    _closeTimer?.cancel();
    _closeTimer = null;
  }

  /// Schedules the popover to open after [hoverOpenDelay].
  void _scheduleOpen() {
    _cancelOpenTimer();
    _openTimer = Timer(widget.hoverOpenDelay, () {
      if (!mounted) return;
      if (_isAnchorHovering) _show();
    });
  }

  /// Schedules the popover to close after [hoverCloseDelay],
  /// but only if the pointer is not on anchor or popover.
  void _scheduleClose() {
    _cancelCloseTimer();
    _closeTimer = Timer(widget.hoverCloseDelay, () async {
      if (!mounted) return;
      if (_shouldStayOpen) return;
      await _close();
    });
  }

  /// Shows the popover using shadcn_flutter's imperative API.
  void _show() {
    showPopover(
      context: context,
      builder: (overlayContext) {
        // Store the overlay context for later closing.
        popoverContext = overlayContext;

        // Keep the popover open while hovering over the popover content.
        return MouseRegion(
          onEnter: (_) {
            _isPopoverHovering = true;
            _cancelCloseTimer();
          },
          onExit: (_) {
            _isPopoverHovering = false;
            if (!_shouldStayOpen) _scheduleClose();
          },
          child: widget.builder(overlayContext),
        );
      },
      alignment: widget.placement,
      offset: widget.offset,
    );
  }

  /// Closes the popover overlay if it is still open.
  ///
  /// The popover might already be closed (e.g. by a click inside it),
  /// so we must verify that the overlay context is still mounted.
  Future<void> _close() async {
    final ctx = popoverContext;

    // No known popover context -> nothing to close.
    if (ctx == null) return;

    // If the overlay was already disposed/unmounted, just forget the reference.
    if (!ctx.mounted) {
      popoverContext = null;
      return;
    }

    // Avoid double close calls racing each other.
    if (_isClosing) return;
    _isClosing = true;

    try {
      await closeOverlay(ctx);
    } catch (_) {
      // If the overlay was closed between the mounted-check and closeOverlay call,
      // some implementations may throw/assert internally. We swallow it safely.
    } finally {
      // Always clear the reference; this prevents reusing a stale BuildContext.
      popoverContext = null;
      _isClosing = false;
    }
  }

  @override
  void dispose() {
    // Prevent pending timers from firing after this widget is disposed.
    _cancelOpenTimer();
    _cancelCloseTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = widget.anchor;

    // Press/click handling:
    // We intercept pointer down above the button.
    // Using Listener avoids GestureArena conflicts with the inner Button implementation.
    //
    // On touch devices, hover does not exist, so press is always the fallback interaction.
    if (widget.enablePress || Responsive.isTouchDevice) {
      result = Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) {
          _show();

          // Optional: still run the original button action.
          if (widget.callOriginalOnPressed) {
            widget.originalOnPressed?.call();
          }
        },
        child: result,
      );
    }

    // Hover handling (desktop/web):
    // Open after a short delay and close with a delay so the popover menu is reachable.
    if (widget.enableHover && !Responsive.isTouchDevice) {
      result = MouseRegion(
        onEnter: (_) {
          _isAnchorHovering = true;
          _cancelCloseTimer();
          _scheduleOpen();
        },
        onExit: (_) {
          _isAnchorHovering = false;
          _cancelOpenTimer();

          // Do not close immediately; allow moving into the popover.
          if (!_shouldStayOpen) _scheduleClose();
        },
        child: result,
      );
    }

    return result;
  }
}
