import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/widget_extensions.dart';
import 'package:police_flutter_template/extensions/widgets/hover_effect.dart';
import 'package:police_flutter_template/extensions/widgets/pulse_animation_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Unit/widget tests for [WidgetExtensions] on [Widget].
///
/// These tests verify that the extension methods behave as pure wrappers:
/// - `enabled: false` returns the original widget instance (identity check).
/// - `enabled: true` returns the expected wrapper type.
///
/// We keep these tests intentionally lightweight:
/// - Visual/animation behavior is tested in the wrapper widgets' own tests.
/// - Here we only ensure the extension wiring stays correct.
void main() {
  group('WidgetExtensions on Widget', () {
    testWidgets('animatePulse: enabled=false gibt identisches Widget zurück', (
      tester,
    ) async {
      const child = Text('x');

      // Act: disabled should be a no-op.
      final result = child.animatePulse(enabled: false);

      // Assert: identity must match.
      expect(identical(result, child), isTrue);

      // Pump a minimal widget to keep this as a proper widget test.
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(),
        ),
      );
    });

    testWidgets('animatePulse: enabled=true wrappt mit PulseAnimationWrapper', (
      tester,
    ) async {
      const child = Text('x');

      // Act: enabled should wrap.
      final result = child.animatePulse(enabled: true);

      // Assert: wrapper type indicates correct implementation.
      expect(result, isA<PulseAnimationWrapper>());

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(),
        ),
      );
    });

    testWidgets('withHoverEffect: liefert HoverEffect Wrapper', (tester) async {
      const child = Text('hover');

      // Act: apply hover effect extension.
      final result = child.withHoverEffect(
        enabled: true,
        hoverScale: 1.02,
        borderWidth: 2,
      );

      // Assert: must return the hover effect widget wrapper.
      expect(result, isA<HoverEffect>());

      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(),
        ),
      );
    });
  });
}
