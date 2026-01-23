import 'package:shadcn_flutter/shadcn_flutter.dart';

class PulseAnimationWrapper extends StatefulWidget {
  const PulseAnimationWrapper({
    super.key,
    required this.child,
    required this.duration,
    required this.lowerBound,
    required this.upperBound,
    required this.curve,
  });

  final Widget child;
  final Duration duration;
  final double lowerBound;
  final double upperBound;
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
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: widget.lowerBound, end: widget.upperBound)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
