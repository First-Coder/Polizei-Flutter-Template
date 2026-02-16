import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/date_extensions.dart';

/// Unit tests for [TimeExtensions] on nullable [DateTime].
///
/// Covered behavior:
/// - Formatting helpers return sensible defaults when the `DateTime?` is null.
/// - Formatting output matches the expected `intl` patterns:
///   - `dd.MM.yyyy - HH:mm`
///   - `dd.MM.yyyy`
///   - `HH:mm`
/// - Week number helper returns 0 on null and remains consistent with the
///   implementation's custom logic.
///
/// Notes:
/// - The `toWeekNumber()` implementation is explicitly **not ISO-8601**.
///   These tests assert the current behavior to prevent unintentional changes.
///   If you later switch to ISO weeks, update tests accordingly.
void main() {
  group('TimeExtensions on DateTime?', () {
    test('toFormatDateTime: null -> elseText oder leerer String', () {
      DateTime? dt;
      expect(dt.toFormatDateTime(elseText: 'n/a'), 'n/a');
      expect(dt.toFormatDateTime(), '');
    });

    test('toFormatDate: null -> elseText oder leerer String', () {
      DateTime? dt;
      expect(dt.toFormatDate(elseText: 'x'), 'x');
      expect(dt.toFormatDate(), '');
    });

    test('toFormatTime: null -> elseText oder leerer String', () {
      DateTime? dt;
      expect(dt.toFormatTime(elseText: '-'), '-');
      expect(dt.toFormatTime(), '');
    });

    test('Formatierung ist dd.MM.yyyy - HH:mm / dd.MM.yyyy / HH:mm', () {
      // Arrange: pick a deterministic DateTime.
      final dt = DateTime(2024, 2, 3, 4, 5);

      // Assert: verify the exact string output to catch locale/pattern regressions.
      expect(dt.toFormatDateTime(), '03.02.2024 - 04:05');
      expect(dt.toFormatDate(), '03.02.2024');
      expect(dt.toFormatTime(), '04:05');
    });

    test('toWeekNumber: null -> 0', () {
      DateTime? dt;
      expect(dt.toWeekNumber(), 0);
    });

    test('toWeekNumber: konsistente Ergebnisse nach implementierter Logik', () {
      // WARNING: This is NOT ISO-8601 week numbering.
      // These expectations match the current custom implementation.
      expect(DateTime(2024, 1, 1).toWeekNumber(), 1); // Monday
      expect(
        DateTime(2024, 1, 7).toWeekNumber(),
        1,
      ); // Sunday still in week 1 by this logic
      expect(DateTime(2024, 1, 8).toWeekNumber(), 2); // next week
    });
  });
}
