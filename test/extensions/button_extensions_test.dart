import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/button_extensions.dart';
import 'package:police_flutter_template/extensions/widgets/button_popover_wrapper.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Unit tests for the `ButtonExtensions` extension on [Widget].
///
/// Scope:
/// - Verifies the extension method `.withPopover(...)` behaves as a pure widget transformer:
///   it either returns the original widget unchanged or returns a wrapper widget.
///
/// What we intentionally do NOT test here:
/// - The actual overlay behavior of `shadcn_flutter` (`showPopover` / `closeOverlay`)
/// - Pointer/hover interaction details (those belong to widget/smoke tests of the wrapper)
///
/// Why these tests matter:
/// - Extensions are easy to regress during refactors (e.g. accidentally always wrapping,
///   or returning a new widget instance even when disabled).
void main() {
  group('ButtonExtensions on Widget', () {
    test('withPopover: enabled=false gibt identisches Widget zurück', () {
      // Arrange: a stable widget instance we can compare by identity.
      const w = Text('btn');

      // Act: disabled extension should act as no-op.
      final result = w.withPopover(
        builder: (_) => const Text('popover'),
        enabled: false,
      );

      // Assert: should return the exact same instance.
      expect(identical(result, w), isTrue);
    });

    test('withPopover: enabled=true liefert ButtonPopoverWrapper', () {
      const w = Text('btn');

      // Act: enabled extension should wrap into the popover wrapper.
      final result = w.withPopover(
        builder: (_) => const Text('popover'),
        enabled: true,
      );

      // Assert: wrapper type indicates that further behavior is delegated correctly.
      expect(result, isA<ButtonPopoverWrapper>());
    });
  });
}
