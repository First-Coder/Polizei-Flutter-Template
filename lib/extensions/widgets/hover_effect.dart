import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A lightweight hover + tap affordance wrapper intended for **web and desktop**
/// platforms.
///
/// This widget provides:
/// - Hover detection via [MouseRegion]
/// - A subtle "lift" effect via [AnimatedScale]
/// - Animated decoration changes (background, shadow, border) via [AnimatedContainer]
///
/// Platform behavior:
/// - On mobile platforms there is no hover; the widget will not listen to hover
///   events (but can still be tappable via [onTap]).
///
/// Typical usage (through an extension):
/// ```dart
/// Card(child: ...)
///   .withHoverEffect(
///     hoverScale: 1.02,
///     borderColor: Colors.gray[200],
///     hoverBorderColor: Colors.blue[400],
///   );
/// ```
class HoverEffect extends StatefulWidget {
  /// Creates a [HoverEffect] wrapper.
  ///
  /// All visual properties are optional except those required to define the
  /// hover animation behavior (duration/curve/scale).
  const HoverEffect({
    super.key,
    required this.child,
    required this.enabled,
    required this.hoverScale,
    required this.duration,
    required this.curve,
    required this.normalShadow,
    required this.hoverShadow,
    required this.normalBackground,
    required this.hoverBackground,
    required this.borderColor,
    required this.hoverBorderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.onTap,
  });

  /// The wrapped content.
  final Widget child;

  /// Whether the hover/tap affordance is enabled.
  ///
  /// If `false`, hover behavior is disabled and the widget behaves like a plain
  /// wrapper (tap handling still works if [onTap] is provided).
  final bool enabled;

  /// The scale applied while hovered.
  ///
  /// Recommended range: `1.01`–`1.03` to keep motion subtle.
  final double hoverScale;

  /// Duration of the hover enter/exit animations.
  final Duration duration;

  /// Curve used for both scaling and decoration transitions.
  final Curve curve;

  /// Shadow used when not hovered.
  final List<BoxShadow>? normalShadow;

  /// Shadow used while hovered.
  final List<BoxShadow>? hoverShadow;

  /// Background color used when not hovered.
  final Color? normalBackground;

  /// Background color used while hovered.
  final Color? hoverBackground;

  /// Border color used when not hovered.
  ///
  /// If null, no border is drawn in the normal state.
  final Color? borderColor;

  /// Border color used while hovered.
  ///
  /// If null, falls back to [borderColor].
  final Color? hoverBorderColor;

  /// Border width used for both normal and hover states.
  final double borderWidth;

  /// Corner radius applied to decoration and clipping.
  final BorderRadius? borderRadius;

  /// Optional padding applied inside the decorated container.
  final EdgeInsetsGeometry? padding;

  /// Optional tap handler. If provided, the widget becomes tappable and the
  /// mouse cursor changes to a click cursor on hover (where supported).
  final VoidCallback? onTap;

  @override
  State<HoverEffect> createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool _hovered = false;

  /// Returns true when hover interactions are meaningful for the current
  /// platform (web/desktop) and the effect is enabled.
  bool get _canHover =>
      widget.enabled &&
          (kIsWeb ||
              {
                TargetPlatform.macOS,
                TargetPlatform.windows,
                TargetPlatform.linux,
              }.contains(defaultTargetPlatform));

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.circular(12);

    final effectiveBorderColor =
    _hovered ? (widget.hoverBorderColor ?? widget.borderColor) : widget.borderColor;

    final decoratedChild = AnimatedContainer(
      duration: widget.duration,
      curve: widget.curve,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: _hovered ? widget.hoverBackground : widget.normalBackground,
        borderRadius: radius,
        boxShadow: _hovered ? widget.hoverShadow : widget.normalShadow,
        border: effectiveBorderColor == null
            ? null
            : Border.all(
          color: effectiveBorderColor,
          width: widget.borderWidth,
        ),
      ),
      child: widget.child,
    );

    final scaledChild = AnimatedScale(
      scale: (_canHover && _hovered) ? widget.hoverScale : 1.0,
      duration: widget.duration,
      curve: widget.curve,
      child: decoratedChild,
    );

    final clickable = widget.onTap == null
        ? scaledChild
        : GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: scaledChild,
    );

    if (!_canHover) return ClipRRect(borderRadius: radius, child: clickable);

    return MouseRegion(
      cursor: widget.onTap == null ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ClipRRect(borderRadius: radius, child: clickable),
    );
  }
}