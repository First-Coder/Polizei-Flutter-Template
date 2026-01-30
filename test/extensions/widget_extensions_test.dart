import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/widget_extensions.dart';
import 'package:police_flutter_template/extensions/widgets/hover_effect.dart';
import 'package:police_flutter_template/extensions/widgets/pulse_animation_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('WidgetExtensions on Widget', () {
    testWidgets('animatePulse: enabled=false gibt identisches Widget zurück', (
      tester,
    ) async {
      const child = Text('x');
      final result = child.animatePulse(enabled: false);
      expect(identical(result, child), isTrue);

      // Pump minimal, damit der Test als Widget-Test sauber läuft
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
      final result = child.animatePulse(enabled: true);
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
      final result = child.withHoverEffect(
        enabled: true,
        hoverScale: 1.02,
        borderWidth: 2,
      );

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
