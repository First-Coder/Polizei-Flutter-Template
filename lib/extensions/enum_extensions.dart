/// Utility mappings for enum values.
///
/// This extension is intended to be used on `MyEnum.values` (an `Iterable<MyEnum>`),
/// and provides common map shapes for:
/// - serialization
/// - UI dropdowns
/// - reverse lookups
///
/// Example:
/// ```dart
/// enum Status { open, closed }
///
/// final byName = Status.values.toNameValueMap; // { 'open': Status.open, ... }
/// final byIndex = Status.values.toIndexNameMap; // { 0: 'open', 1: 'closed' }
/// ```
extension EnumExtensions<T extends Enum> on Iterable<T> {
  /// Creates a map where:
  /// - key: `enumValue.name`
  /// - value: `enumValue.index`
  ///
  /// Example: `MyEnum.values.toNameIndexMap` -> `{'valueOne': 0, 'valueTwo': 1}`
  Map<String, int> get toNameIndexMap {
    return {for (var value in this) value.name: value.index};
  }

  /// Creates a map where:
  /// - key: `enumValue.index`
  /// - value: `enumValue.name`
  ///
  /// Example: `MyEnum.values.toIndexNameMap` -> `{0: 'valueOne', 1: 'valueTwo'}`
  Map<int, String> get toIndexNameMap {
    return {for (var value in this) value.index: value.name};
  }

  /// Creates a map where:
  /// - key: `enumValue.name`
  /// - value: `enumValue` (the enum value itself)
  ///
  /// Example: `MyEnum.values.toNameValueMap` -> `{'valueOne': MyEnum.valueOne, ...}`
  Map<String, T> get toNameValueMap {
    return {for (var value in this) value.name: value};
  }
}
