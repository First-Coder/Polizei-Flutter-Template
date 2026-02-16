import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A small helper widget that applies a repeating "pulse" animation to its [child].
///
/// Implementation details:
/// - Uses an [AnimationController] that repeats forever (with `reverse: true`).
/// - Drives a [FadeTransition] by animating the opacity between [lowerBound] and [upperBound].
///
/// Typical use cases:
/// - Subtle attention cues (e.g. "live" indicator, status dot, hinting an actionable UI)
/// - Temporarily drawing attention to a widget without disruptive motion
///
/// Notes:
/// - This animates **opacity**, not scale.
/// - Bounds should usually stay within `0.0..1.0`.
class PulseAnimationWrapper extends StatefulWidget {
  /// Creates a pulsing animation wrapper.
  const PulseAnimationWrapper({
    super.key,
    required this.child,
    required this.duration,
    required this.lowerBound,
    required this.upperBound,
    required this.curve,
  });

  /// The widget to animate.
  final Widget child;

  /// Duration of one half-cycle (forward or reverse), depending on controller usage.
  ///
  /// With `repeat(reverse: true)` this roughly defines the pulse speed.
  final Duration duration;

  /// The minimum opacity.
  final double lowerBound;

  /// The maximum opacity.
  final double upperBound;

  /// Curve applied to the opacity animation.
  final Curve curve;

  @override
  State<PulseAnimationWrapper> createState() => _PulseAnimationWrapperState();
}

class _PulseAnimationWrapperState extends State<PulseAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(
      begin: widget.lowerBound,
      end: widget.upperBound,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}
