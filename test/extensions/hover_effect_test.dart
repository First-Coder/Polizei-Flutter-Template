import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/widgets/hover_effect.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('HoverEffect', () {
    testWidgets(
      'in Tests meist kein Hover (Platform), daher kein MouseRegion; Tap funktioniert',
      (tester) async {
        var tapped = 0;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: HoverEffect(
              enabled: true,
              hoverScale: 1.02,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
              normalShadow: null,
              hoverShadow: null,
              normalBackground: null,
              hoverBackground: null,
              borderColor: null,
              hoverBorderColor: null,
              borderWidth: 1,
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.all(8),
              onTap: () => tapped++,
              child: const Text('tap'),
            ),
          ),
        );

        // Default ist typischerweise Android im Test -> _canHover=false
        expect(find.byType(MouseRegion), findsNothing);

        await tester.tap(find.text('tap'));
        expect(tapped, 1);
      },
    );

    testWidgets(
      'enabled=false: baut stabil und tap funktioniert, wenn onTap gesetzt',
      (tester) async {
        var tapped = 0;

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: HoverEffect(
              enabled: false,
              hoverScale: 1.05,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              normalShadow: null,
              hoverShadow: null,
              normalBackground: null,
              hoverBackground: null,
              borderColor: null,
              hoverBorderColor: null,
              borderWidth: 1,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.all(4),
              onTap: () => tapped++,
              child: const Text('x'),
            ),
          ),
        );

        await tester.tap(find.text('x'));
        expect(tapped, 1);
      },
    );
  });
}
