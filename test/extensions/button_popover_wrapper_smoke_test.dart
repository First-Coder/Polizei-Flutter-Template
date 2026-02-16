import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/widgets/button_popover_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Smoke test for [ButtonPopoverWrapper].
///
/// Goal:
/// - Ensure the widget can be built in a widget-test environment without
///   triggering the imperative overlay logic (`showPopover`) as a side effect.
///
/// Why a smoke test?
/// - The wrapper contains timers, pointer listeners, and overlay context handling.
///   A minimal "build does not crash" test provides quick regression coverage.
///
/// What is *not* covered here:
/// - Press/hover interaction semantics
/// - Actual overlay content appearance and dismissal
/// - Hover intent timing behavior (open/close delay correctness)
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
              anchorAlignment: null,
              offset: const Offset(0, 8),
            ),
          ),
        );

        // The anchor must be present; if building fails due to overlay/timer issues
        // this expectation will never be reached.
        expect(find.text('anchor'), findsOneWidget);
      },
    );
  });
}
