import 'package:police_flutter_template/extensions/widgets/button_popover_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Extension methods for buttons.
extension ButtonExtensions on Widget {
  /// Wraps this Button and shows a popover using the imperative shadcn_flutter API.
  ///
  /// Why wrap instead of mutating `onPressed`?
  /// - `Button.onPressed` is `final` and cannot be reassigned.
  /// - Extensions can't modify existing instance fields; they can only return new widgets.
  ///
  /// Hover behavior:
  /// - On desktop/web, [enableHover] uses MouseRegion.
  Widget withPopover({
    required Widget Function(BuildContext) builder,

    bool enabled = true,

    // Press behavior
    bool enablePress = true,
    bool callOriginalOnPressed = false,
    VoidCallback? originalOnPressed,

    // Hover behavior
    bool enableHover = false,
    Duration hoverOpenDelay = const Duration(milliseconds: 120),
    Duration hoverCloseDelay = const Duration(milliseconds: 200),

    // Optional positioning (adjust to your showPopover signature)
    Alignment placement = Alignment.bottomCenter,
    Offset offset = const Offset(0, 8),
  }) {
    if(!enabled) return this;
    return ButtonPopoverWrapper(
      anchor: this,
      builder: builder,
      enablePress: enablePress,
      callOriginalOnPressed: callOriginalOnPressed,
      originalOnPressed: originalOnPressed,
      enableHover: enableHover,
      hoverOpenDelay: hoverOpenDelay,
      hoverCloseDelay: hoverCloseDelay,
      placement: placement,
      offset: offset,
    );
  }
}
