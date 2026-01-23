extension EnumExtensions<T extends Enum> on Iterable<T> {
  /// Creates a map from the values of this enum,
  /// where the enum name is the key and the enum index is the value.
  /// Example: `MyEnum.values.toNameIndexMap` -> `{'valueOne': 0, 'valueTwo': 1}`
  Map<String, int> get toNameIndexMap {
    return {
      for (var value in this)
        value.name: value.index,
    };
  }

  /// Creates a map from the values of this enum,
  /// where the enum index is the key and the enum name is the value.
  /// Example: `MyEnum.values.toIndexNameMap` -> `{0: 'valueOne', 1: 'valueTwo'}`
  Map<int, String> get toIndexNameMap {
    return {
      for (var value in this)
        value.index: value.name,
    };
  }

  /// Creates a map from the values of this enum,
  /// where the enum name is the key and the enum value itself is the value.
  /// Example: `MyEnum.values.toNameValueMap` -> `{'valueOne': MyEnum.valueOne, 'valueTwo': MyEnum.valueTwo}`
  Map<String, T> get toNameValueMap {
    return {
      for (var value in this)
        value.name: value,
    };
  }
}