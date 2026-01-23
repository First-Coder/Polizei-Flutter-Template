import 'package:police_flutter_template/extensions/widgets/pulse_animation_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Extension methods for pulse animation.
extension PulseAnimation on Widget {
  Widget animatePulse({
    bool enabled = true,
    Duration duration = const Duration(seconds: 2),
    double lowerBound = 0.5,
    double upperBound = 1.0,
    Curve curve = Curves.easeInOut,
  }) {
    if (!enabled) {
      return this;
    }
    return PulseAnimationWrapper(
      duration: duration,
      lowerBound: lowerBound,
      upperBound: upperBound,
      curve: curve,
      child: this,
    );
  }
}
