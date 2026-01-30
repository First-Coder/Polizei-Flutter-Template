import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/date_extensions.dart';

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
      final dt = DateTime(2024, 2, 3, 4, 5);
      expect(dt.toFormatDateTime(), '03.02.2024 - 04:05');
      expect(dt.toFormatDate(), '03.02.2024');
      expect(dt.toFormatTime(), '04:05');
    });

    test('toWeekNumber: null -> 0', () {
      DateTime? dt;
      expect(dt.toWeekNumber(), 0);
    });

    test('toWeekNumber: konsistente Ergebnisse nach implementierter Logik', () {
      // Achtung: Das ist NICHT ISO-8601 Kalenderwoche, sondern die im Code implementierte Berechnung.
      expect(DateTime(2024, 1, 1).toWeekNumber(), 1); // Montag
      expect(
        DateTime(2024, 1, 7).toWeekNumber(),
        1,
      ); // Sonntag gehört zur Woche ab 01.01.
      expect(DateTime(2024, 1, 8).toWeekNumber(), 2); // nächste Woche
    });
  });
}
