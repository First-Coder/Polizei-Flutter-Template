import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/widgets/pulse_animation_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Widget tests for [PulseAnimationWrapper].
///
/// Covered behavior:
/// - The wrapper builds a [FadeTransition] (i.e. it animates opacity).
/// - The animated opacity value stays within the configured [lowerBound] and [upperBound].
/// - The animation changes over time (basic "it moves" assertion).
///
/// Notes:
/// - This is intentionally *not* a golden/visual test.
/// - We avoid relying on exact animation values (which can be timing-sensitive),
///   and instead assert bounds + change after pumping time.
void main() {
  group('PulseAnimationWrapper', () {
    testWidgets(
      'baut eine FadeTransition und opacity bleibt innerhalb der bounds',
      (tester) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: PulseAnimationWrapper(
              duration: Duration(milliseconds: 200),
              lowerBound: 0.2,
              upperBound: 0.8,
              curve: Curves.linear,
              child: Text('x'),
            ),
          ),
        );

        // Read the current opacity value from the FadeTransition animation.
        final fade1 = tester.widget<FadeTransition>(
          find.byType(FadeTransition),
        );
        final v1 = fade1.opacity.value;
        expect(v1, inInclusiveRange(0.2, 0.8));

        // Advance time to allow the controller to tick.
        await tester.pump(const Duration(milliseconds: 100));

        final fade2 = tester.widget<FadeTransition>(
          find.byType(FadeTransition),
        );
        final v2 = fade2.opacity.value;
        expect(v2, inInclusiveRange(0.2, 0.8));

        // In practice the value should change after pumping time.
        expect(v2, isNot(equals(v1)));
      },
    );
  });
}
