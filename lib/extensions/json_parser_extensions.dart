import 'package:intl/intl.dart';

/// Convenience accessors for parsing loosely-typed JSON maps (`Map<String, dynamic>`).
///
/// Goals:
/// - Reduce repetitive `containsKey` / type checks across the codebase.
/// - Provide both **safe** (`getX`) and **strict** (`getXOrThrow`) variants.
/// - Support common "API quirks", e.g. numbers returned as strings.
///
/// Design notes:
/// - These helpers are intentionally conservative: they only parse values they recognize.
/// - For complex/nested objects, prefer dedicated model parsing instead of extending this file.
///
/// Example:
/// ```dart
/// final id = json.getIntOrThrow('id');
/// final title = json.getString('title', defaultValue: '(untitled)') ?? '(untitled)';
/// ```
extension JsonParserExtensions on Map<String, dynamic> {
  /// Attempts to parse the value at [key] as a [String].
  ///
  /// Returns [defaultValue] if:
  /// - the key does not exist, OR
  /// - the value is not a `String`.
  String? getString(String key, {String? defaultValue}) {
    if (containsKey(key) && this[key] is String) {
      return this[key] as String?;
    }
    return defaultValue;
  }

  /// Returns the value at [key] as a [String] or throws.
  ///
  /// Throws a [FormatException] if:
  /// - the key does not exist, OR
  /// - the value is not a `String`.
  String getStringOrThrow(String key) {
    if (containsKey(key) && this[key] is String) {
      return this[key] as String;
    }
    throw FormatException("Key '$key' not found or not a String in JSON map.");
  }

  /// Attempts to parse the value at [key] as an [int].
  ///
  /// Accepted inputs:
  /// - `int` (returned as-is)
  /// - `String` (parsed via `int.tryParse`)
  ///
  /// Returns [defaultValue] on missing key or parse failure.
  int? getInt(String key, {int? defaultValue}) {
    if (containsKey(key)) {
      if (this[key] is int) {
        return this[key] as int?;
      } else if (this[key] is String) {
        return int.tryParse(this[key] as String) ?? defaultValue;
      }
    }
    return defaultValue;
  }

  /// Returns the value at [key] as an [int] or throws.
  ///
  /// Accepted inputs:
  /// - `int`
  /// - `String` parsable as `int`
  ///
  /// Throws a [FormatException] otherwise.
  int getIntOrThrow(String key) {
    if (containsKey(key)) {
      if (this[key] is int) {
        return this[key] as int;
      } else if (this[key] is String) {
        final parsedInt = int.tryParse(this[key] as String);
        if (parsedInt != null) {
          return parsedInt;
        }
      }
    }
    throw FormatException(
      "Key '$key' not found or not parsable as an int in JSON map.",
    );
  }

  /// Attempts to parse the value at [key] as a [double].
  ///
  /// Accepted inputs:
  /// - `double` (returned as-is)
  /// - `int` (converted to double)
  /// - `String` (parsed via `double.tryParse`)
  ///
  /// Returns [defaultValue] on missing key or parse failure.
  double? getDouble(String key, {double? defaultValue}) {
    if (containsKey(key)) {
      if (this[key] is double) {
        return this[key] as double?;
      } else if (this[key] is int) {
        return (this[key] as int).toDouble();
      } else if (this[key] is String) {
        return double.tryParse(this[key] as String) ?? defaultValue;
      }
    }
    return defaultValue;
  }

  /// Returns the value at [key] as a [double] or throws.
  ///
  /// Accepted inputs:
  /// - `double`
  /// - `int` (converted)
  /// - `String` parsable as `double`
  ///
  /// Throws a [FormatException] otherwise.
  double getDoubleOrThrow(String key) {
    if (containsKey(key)) {
      if (this[key] is double) {
        return this[key] as double;
      } else if (this[key] is int) {
        return (this[key] as int).toDouble();
      } else if (this[key] is String) {
        final parsedDouble = double.tryParse(this[key] as String);
        if (parsedDouble != null) {
          return parsedDouble;
        }
      }
    }
    throw FormatException(
      "Key '$key' not found or not parsable as a double in JSON map.",
    );
  }

  /// Attempts to parse the value at [key] as a [bool].
  ///
  /// Accepted inputs:
  /// - `bool`
  /// - `String` `"true"` / `"false"` (case-insensitive)
  ///
  /// Returns [defaultValue] on missing key or parse failure.
  bool? getBool(String key, {bool? defaultValue}) {
    if (containsKey(key)) {
      if (this[key] is bool) {
        return this[key] as bool?;
      } else if (this[key] is String) {
        final lowerCaseValue = (this[key] as String).toLowerCase();
        if (lowerCaseValue == 'true') {
          return true;
        } else if (lowerCaseValue == 'false') {
          return false;
        }
      }
    }
    return defaultValue;
  }

  /// Returns the value at [key] as a [bool] or throws.
  ///
  /// Accepted inputs:
  /// - `bool`
  /// - `String` `"true"` / `"false"` (case-insensitive)
  ///
  /// Throws a [FormatException] otherwise.
  bool getBoolOrThrow(String key) {
    if (containsKey(key)) {
      if (this[key] is bool) {
        return this[key] as bool;
      } else if (this[key] is String) {
        final lowerCaseValue = (this[key] as String).toLowerCase();
        if (lowerCaseValue == 'true') {
          return true;
        } else if (lowerCaseValue == 'false') {
          return false;
        }
      }
    }
    throw FormatException(
      "Key '$key' not found or not parsable as a bool in JSON map.",
    );
  }

  /// Attempts to parse the value at [key] as a [List] of type [T].
  ///
  /// Returns [defaultValue] if:
  /// - key missing, OR
  /// - value is not a `List`, OR
  /// - the cast to `List<T>` fails.
  ///
  /// Tip: For lists of nested objects, prefer explicit mapping/parsing.
  List<T>? getList<T>(String key, {List<T>? defaultValue}) {
    if (containsKey(key) && this[key] is List) {
      try {
        return List<T>.from(this[key] as List);
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  /// Extracts a list of strings from a list-like JSON property.
  ///
  /// Expected structure:
  /// - `this[key]` is a `List`
  /// - each element in that list supports `containsKey(subKey)` and `element[subKey]`
  ///
  /// Returns `null` if the structure doesn't match or if no values were found.
  ///
  /// Note: This method assumes dynamic map-like elements; use with care.
  List<String>? getProjectPropertyList(String key, String subKey) {
    final List<String> result = [];
    if (containsKey(key) && this[key] is List) {
      try {
        for (var element in this[key] as List) {
          if (element.containsKey(subKey)) {
            result.add(element[subKey].toString());
          }
        }
        return result.isEmpty ? null : result;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Returns the value at [key] as a `List<T>` or throws.
  ///
  /// Throws a [FormatException] if:
  /// - key missing, OR
  /// - value is not a `List`, OR
  /// - elements cannot be cast to [T].
  List<T> getListOrThrow<T>(String key) {
    if (containsKey(key) && this[key] is List) {
      try {
        return List<T>.from(this[key] as List);
      } catch (e) {
        throw FormatException(
          "Key '$key' contains a List, but its elements could not be cast to type '$T': ${e.toString()}",
        );
      }
    }
    throw FormatException("Key '$key' not found or not a List in JSON map.");
  }

  /// Attempts to parse the value at [key] as a `Map<String, dynamic>`.
  ///
  /// Returns [defaultValue] on missing key or type mismatch.
  Map<String, dynamic>? getMap(
    String key, {
    Map<String, dynamic>? defaultValue,
  }) {
    if (containsKey(key) && this[key] is Map<String, dynamic>) {
      return this[key] as Map<String, dynamic>?;
    }
    return defaultValue;
  }

  /// Returns the value at [key] as a `Map<String, dynamic>` or throws.
  ///
  /// Throws a [FormatException] on missing key or type mismatch.
  Map<String, dynamic> getMapOrThrow(String key) {
    if (containsKey(key) && this[key] is Map<String, dynamic>) {
      return this[key] as Map<String, dynamic>;
    }
    throw FormatException(
      "Key '$key' not found or not a Map<String, dynamic> in JSON map.",
    );
  }

  /// Attempts to parse the value at [key] as a [DateTime] using `DateTime.parse`.
  ///
  /// Expected input:
  /// - `String` in a format supported by `DateTime.parse` (often ISO-8601)
  ///
  /// Returns [defaultValue] if parsing fails or key/type is missing.
  DateTime? getDateTime(String key, {DateTime? defaultValue}) {
    if (containsKey(key) && this[key] is String) {
      try {
        return DateTime.parse(this[key] as String);
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  /// Returns the value at [key] as a [DateTime] or throws.
  ///
  /// Throws a [FormatException] if:
  /// - key missing, OR
  /// - value is not a `String`, OR
  /// - parsing via `DateTime.parse` fails.
  DateTime getDateTimeOrThrow(String key) {
    if (containsKey(key) && this[key] is String) {
      try {
        return DateTime.parse(this[key] as String);
      } catch (e) {
        throw FormatException(
          "Key '$key' contains a String '${this[key]}' that could not be parsed as a DateTime: ${e.toString()}",
        );
      }
    }
    throw FormatException(
      "Key '$key' not found or not a String suitable for DateTime parsing in JSON map.",
    );
  }

  /// Attempts to parse the value at [key] as a [DateTime] using a specific [format].
  ///
  /// Requires the `intl` package.
  /// Returns [defaultValue] on missing key, type mismatch, or parse failure.
  DateTime? getDateTimeWithFormat(
    String key,
    DateFormat format, {
    DateTime? defaultValue,
  }) {
    if (containsKey(key) && this[key] is String) {
      try {
        return format.parse(this[key] as String);
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  /// Returns the value at [key] as a [DateTime] using [format] or throws.
  ///
  /// Throws a [FormatException] if:
  /// - key missing, OR
  /// - value is not a `String`, OR
  /// - parsing with the given [format] fails.
  DateTime getDateTimeWithFormatOrThrow(String key, DateFormat format) {
    if (containsKey(key) && this[key] is String) {
      try {
        return format.parse(this[key] as String);
      } catch (e) {
        throw FormatException(
          "Key '$key' contains a String '${this[key]}' that could not be parsed with the format '${format.pattern}': ${e.toString()}",
        );
      }
    }
    throw FormatException(
      "Key '$key' not found or not a String suitable for DateTime parsing with format in JSON map.",
    );
  }
}
