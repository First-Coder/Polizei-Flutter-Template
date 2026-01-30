import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:police_flutter_template/extensions/json_parser_extensions.dart';

void main() {
  group('JsonParserExtensions on Map<String, dynamic>', () {
    group('getString / getStringOrThrow', () {
      test('getString: String vorhanden -> Wert', () {
        final Map<String, dynamic> json = <String, dynamic>{'a': 'hello'};
        expect(json.getString('a'), 'hello');
      });

      test('getString: fehlend oder falscher Typ -> defaultValue', () {
        final Map<String, dynamic> json = <String, dynamic>{'a': 123};
        expect(json.getString('a', defaultValue: 'x'), 'x');
        expect(json.getString('missing', defaultValue: 'x'), 'x');
      });

      test('getStringOrThrow: wirft bei fehlend oder falschem Typ', () {
        final Map<String, dynamic> wrongType = <String, dynamic>{'a': 1};
        expect(() => wrongType.getStringOrThrow('a'), throwsFormatException);

        final Map<String, dynamic> empty = <String, dynamic>{};
        expect(() => empty.getStringOrThrow('missing'), throwsFormatException);
      });
    });

    group('getInt / getIntOrThrow', () {
      test('getInt: int direkt / String parsebar / default', () {
        expect(<String, dynamic>{'a': 1}.getInt('a'), 1);
        expect(<String, dynamic>{'a': '42'}.getInt('a'), 42);
        expect(<String, dynamic>{'a': 'x'}.getInt('a', defaultValue: 7), 7);
        expect(<String, dynamic>{}.getInt('a', defaultValue: 7), 7);
      });

      test('getIntOrThrow: int direkt / String parsebar / wirft sonst', () {
        expect(<String, dynamic>{'a': 1}.getIntOrThrow('a'), 1);
        expect(<String, dynamic>{'a': '42'}.getIntOrThrow('a'), 42);
        expect(
          () => <String, dynamic>{'a': 'x'}.getIntOrThrow('a'),
          throwsFormatException,
        );
        expect(
          () => <String, dynamic>{}.getIntOrThrow('a'),
          throwsFormatException,
        );
      });
    });

    group('getDouble / getDoubleOrThrow', () {
      test('getDouble: double / int->double / String parsebar / default', () {
        expect(<String, dynamic>{'a': 1.5}.getDouble('a'), 1.5);
        expect(<String, dynamic>{'a': 2}.getDouble('a'), 2.0);
        expect(<String, dynamic>{'a': '3.25'}.getDouble('a'), 3.25);
        expect(
          <String, dynamic>{'a': 'x'}.getDouble('a', defaultValue: 9.0),
          9.0,
        );
        expect(<String, dynamic>{}.getDouble('a', defaultValue: 9.0), 9.0);
      });

      test(
        'getDoubleOrThrow: double / int / String parsebar / wirft sonst',
        () {
          expect(<String, dynamic>{'a': 1.5}.getDoubleOrThrow('a'), 1.5);
          expect(<String, dynamic>{'a': 2}.getDoubleOrThrow('a'), 2.0);
          expect(<String, dynamic>{'a': '3.25'}.getDoubleOrThrow('a'), 3.25);
          expect(
            () => <String, dynamic>{'a': 'x'}.getDoubleOrThrow('a'),
            throwsFormatException,
          );
          expect(
            () => <String, dynamic>{}.getDoubleOrThrow('a'),
            throwsFormatException,
          );
        },
      );
    });

    group('getBool / getBoolOrThrow', () {
      test(
        'getBool: bool direkt / String true|false (case-insensitive) / default',
        () {
          expect(<String, dynamic>{'a': true}.getBool('a'), true);
          expect(<String, dynamic>{'a': 'true'}.getBool('a'), true);
          expect(<String, dynamic>{'a': 'TrUe'}.getBool('a'), true);
          expect(<String, dynamic>{'a': 'false'}.getBool('a'), false);

          expect(
            <String, dynamic>{'a': 'nope'}.getBool('a', defaultValue: true),
            true,
          );
          expect(<String, dynamic>{}.getBool('a', defaultValue: false), false);
        },
      );

      test('getBoolOrThrow: bool direkt / String true|false / wirft sonst', () {
        expect(<String, dynamic>{'a': true}.getBoolOrThrow('a'), true);
        expect(<String, dynamic>{'a': 'false'}.getBoolOrThrow('a'), false);
        expect(
          () => <String, dynamic>{'a': 'nope'}.getBoolOrThrow('a'),
          throwsFormatException,
        );
        expect(
          () => <String, dynamic>{}.getBoolOrThrow('a'),
          throwsFormatException,
        );
      });
    });

    group('getList / getListOrThrow', () {
      test('getList<T>: List castbar -> Liste, sonst default', () {
        expect(
          <String, dynamic>{
            'a': [1, 2, 3],
          }.getList<int>('a'),
          [1, 2, 3],
        );
        expect(
          <String, dynamic>{
            'a': ['x', 'y'],
          }.getList<String>('a'),
          ['x', 'y'],
        );

        // falscher Typ am Key -> defaultValue
        expect(
          <String, dynamic>{
            'a': 'no',
          }.getList<String>('a', defaultValue: ['d']),
          ['d'],
        );

        // Elemente nicht castbar -> defaultValue
        expect(
          <String, dynamic>{
            'a': [1, 'x'],
          }.getList<int>('a', defaultValue: [9]),
          [9],
        );
      });

      test(
        'getListOrThrow<T>: wirft bei fehlend / falschem Typ / nicht castbar',
        () {
          expect(
            <String, dynamic>{
              'a': [1, 2],
            }.getListOrThrow<int>('a'),
            [1, 2],
          );

          expect(
            () => <String, dynamic>{}.getListOrThrow<int>('a'),
            throwsFormatException,
          );
          expect(
            () => <String, dynamic>{'a': 'x'}.getListOrThrow<int>('a'),
            throwsFormatException,
          );
          expect(
            () => <String, dynamic>{
              'a': [1, 'x'],
            }.getListOrThrow<int>('a'),
            throwsFormatException,
          );
        },
      );
    });

    group('getMap / getMapOrThrow', () {
      test('getMap: Map vorhanden -> Map, sonst defaultValue', () {
        expect(
          <String, dynamic>{
            'm': <String, dynamic>{'a': 1},
          }.getMap('m'),
          <String, dynamic>{'a': 1},
        );
        expect(
          <String, dynamic>{
            'm': 123,
          }.getMap('m', defaultValue: <String, dynamic>{'x': 1}),
          <String, dynamic>{'x': 1},
        );
      });

      test('getMapOrThrow: wirft bei fehlend oder falschem Typ', () {
        expect(
          () => <String, dynamic>{'m': 123}.getMapOrThrow('m'),
          throwsFormatException,
        );
        expect(
          () => <String, dynamic>{}.getMapOrThrow('m'),
          throwsFormatException,
        );
      });
    });

    group('getDateTime / getDateTimeOrThrow', () {
      test(
        'getDateTime: ISO-String parsebar / default bei Fehler oder fehlend',
        () {
          final dt = <String, dynamic>{
            'd': '2024-01-02T03:04:05.000Z',
          }.getDateTime('d');
          expect(dt, isA<DateTime>());

          expect(
            <String, dynamic>{
              'd': 'invalid',
            }.getDateTime('d', defaultValue: DateTime(2000)),
            DateTime(2000),
          );

          expect(
            <String, dynamic>{}.getDateTime('d', defaultValue: DateTime(2000)),
            DateTime(2000),
          );
        },
      );

      test('getDateTimeOrThrow: wirft bei fehlend/invalid', () {
        expect(
          <String, dynamic>{
            'd': '2024-01-02T03:04:05.000Z',
          }.getDateTimeOrThrow('d'),
          isA<DateTime>(),
        );
        expect(
          () => <String, dynamic>{'d': 'invalid'}.getDateTimeOrThrow('d'),
          throwsFormatException,
        );
        expect(
          () => <String, dynamic>{}.getDateTimeOrThrow('d'),
          throwsFormatException,
        );
      });
    });

    group('getDateTimeWithFormat / getDateTimeWithFormatOrThrow', () {
      test(
        'getDateTimeWithFormat: parsebar / default bei Fehler oder fehlend',
        () {
          final fmt = DateFormat('dd.MM.yyyy');

          expect(
            <String, dynamic>{
              'd': '03.02.2024',
            }.getDateTimeWithFormat('d', fmt),
            DateTime(2024, 2, 3),
          );

          expect(
            <String, dynamic>{
              'd': 'x',
            }.getDateTimeWithFormat('d', fmt, defaultValue: DateTime(2001)),
            DateTime(2001),
          );

          expect(
            <String, dynamic>{}.getDateTimeWithFormat(
              'd',
              fmt,
              defaultValue: DateTime(2001),
            ),
            DateTime(2001),
          );
        },
      );

      test('getDateTimeWithFormatOrThrow: wirft bei fehlend/invalid', () {
        final fmt = DateFormat('dd.MM.yyyy');

        expect(
          <String, dynamic>{
            'd': '03.02.2024',
          }.getDateTimeWithFormatOrThrow('d', fmt),
          DateTime(2024, 2, 3),
        );

        expect(
          () => <String, dynamic>{
            'd': 'x',
          }.getDateTimeWithFormatOrThrow('d', fmt),
          throwsFormatException,
        );
        expect(
          () => <String, dynamic>{}.getDateTimeWithFormatOrThrow('d', fmt),
          throwsFormatException,
        );
      });
    });

    group('getProjectPropertyList', () {
      test(
        'extrahiert subKey aus List-Elementen, ignoriert Elemente ohne subKey',
        () {
          final Map<String, dynamic> json = <String, dynamic>{
            'items': <dynamic>[
              <String, dynamic>{'name': 'a'},
              <String, dynamic>{'name': 'b'},
              <String, dynamic>{'other': 'x'},
            ],
          };

          expect(json.getProjectPropertyList('items', 'name'), <String>[
            'a',
            'b',
          ]);
        },
      );

      test('liefert null bei leerem Ergebnis oder falscher Struktur', () {
        final Map<String, dynamic> noMatches = <String, dynamic>{
          'items': <dynamic>[
            <String, dynamic>{'other': 'x'},
          ],
        };
        expect(noMatches.getProjectPropertyList('items', 'name'), isNull);

        final Map<String, dynamic> wrongType = <String, dynamic>{
          'items': 'nope',
        };
        expect(wrongType.getProjectPropertyList('items', 'name'), isNull);

        final Map<String, dynamic> missing = <String, dynamic>{};
        expect(missing.getProjectPropertyList('items', 'name'), isNull);
      });
    });
  });
}
