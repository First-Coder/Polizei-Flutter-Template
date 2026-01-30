import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/widgets/button_popover_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('ButtonPopoverWrapper (smoke)', () {
    testWidgets(
      'baut den Anchor ohne Interaktion (imperatives showPopover nicht triggern)',
      (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: ButtonPopoverWrapper(
              anchor: const Text('anchor'),
              builder: (_) => const Text('popover'),
              enablePress: false,
              callOriginalOnPressed: false,
              originalOnPressed: null,
              enableHover: false,
              hoverOpenDelay: const Duration(milliseconds: 10),
              hoverCloseDelay: const Duration(milliseconds: 10),
              placement: Alignment.bottomCenter,
              offset: const Offset(0, 8),
            ),
          ),
        );

        expect(find.text('anchor'), findsOneWidget);
      },
    );
  });
}
