import 'package:flutter_test/flutter_test.dart';
import 'package:police_flutter_template/extensions/enum_extensions.dart';

/// Unit tests for [EnumExtensions] on `Iterable<T extends Enum>`.
///
/// Covered behavior:
/// - Map shapes are correct and deterministic for a known enum.
/// - Empty iterables produce empty maps (no exceptions, no nulls).
///
/// Why it matters:
/// - These maps are often used for serialization and UI binding. A subtle change
///   (e.g. using `toString()` instead of `name`) can break persisted data formats.
enum _TestEnum { alpha, beta, gamma }

void main() {
  group('EnumExtensions<T extends Enum> on Iterable<T>', () {
    test('toNameIndexMap erstellt name -> index', () {
      final map = _TestEnum.values.toNameIndexMap;
      expect(map, {'alpha': 0, 'beta': 1, 'gamma': 2});
    });

    test('toIndexNameMap erstellt index -> name', () {
      final map = _TestEnum.values.toIndexNameMap;
      expect(map, {0: 'alpha', 1: 'beta', 2: 'gamma'});
    });

    test('toNameValueMap erstellt name -> enum value', () {
      final map = _TestEnum.values.toNameValueMap;
      expect(map['alpha'], _TestEnum.alpha);
      expect(map['beta'], _TestEnum.beta);
      expect(map['gamma'], _TestEnum.gamma);
    });

    test('leere Iterable ergibt leere Maps', () {
      final empty = <_TestEnum>[];
      expect(empty.toNameIndexMap, isEmpty);
      expect(empty.toIndexNameMap, isEmpty);
      expect(empty.toNameValueMap, isEmpty);
    });
  });
}
