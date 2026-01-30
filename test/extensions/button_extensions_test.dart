import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/button_extensions.dart';
import 'package:police_flutter_template/extensions/widgets/button_popover_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  group('ButtonExtensions on Widget', () {
    test('withPopover: enabled=false gibt identisches Widget zurück', () {
      const w = Text('btn');
      final result = w.withPopover(
        builder: (_) => const Text('popover'),
        enabled: false,
      );
      expect(identical(result, w), isTrue);
    });

    test('withPopover: enabled=true liefert ButtonPopoverWrapper', () {
      const w = Text('btn');
      final result = w.withPopover(
        builder: (_) => const Text('popover'),
        enabled: true,
      );
      expect(result, isA<ButtonPopoverWrapper>());
    });
  });
}
