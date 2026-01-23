import 'package:intl/intl.dart';

extension JsonParserExtensions on Map<String, dynamic> {
  /// Attempts to parse the value of the specified [key] as a [String].
  /// Returns [defaultValue] if the key does not exist or the value cannot be parsed as a String.
  String? getString(String key, {String? defaultValue}) {
    if (containsKey(key) && this[key] is String) {
      return this[key] as String?;
    }
    return defaultValue;
  }

  /// Parses the value of the specified [key] as a [String].
  /// Throws a [FormatException] if the key does not exist or the value is not a String.
  String getStringOrThrow(String key) {
    if (containsKey(key) && this[key] is String) {
      return this[key] as String;
    }
    throw FormatException("Key '$key' not found or not a String in JSON map.");
  }

  /// Attempts to parse the value of the specified [key] as an [int].
  /// Returns [defaultValue] if the key does not exist or the value cannot be parsed as an int.
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

  /// Parses the value of the specified [key] as an [int].
  /// Throws a [FormatException] if the key does not exist or the value cannot be parsed as an int.
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

  /// Attempts to parse the value of the specified [key] as a [double].
  /// Returns [defaultValue] if the key does not exist or the value cannot be parsed as a double.
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

  /// Parses the value of the specified [key] as a [double].
  /// Throws a [FormatException] if the key does not exist or the value cannot be parsed as a double.
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

  /// Attempts to parse the value of the specified [key] as a [bool].
  /// Accepts boolean values directly or strings like "true" or "false" (case-insensitive).
  /// Returns [defaultValue] if the key does not exist or the value cannot be parsed as a bool.
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

  /// Parses the value of the specified [key] as a [bool].
  /// Throws a [FormatException] if the key does not exist or the value cannot be parsed as a bool.
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

  /// Attempts to parse the value of the specified [key] as a [List<T>].
  /// Returns [defaultValue] if the key does not exist or the value is not a List.
  /// You need to specify the type [T] for the elements of the list.
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

  /// Parses a project property as a list of strings.
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

  /// Parses the value of the specified [key] as a [List<T>].
  /// Throws a [FormatException] if the key does not exist, the value is not a List,
  /// or if elements cannot be cast to type [T].
  List<T> getListOrThrow<T>(String key) {
    if (containsKey(key) && this[key] is List) {
      try {
        // This simple List<T>.from might still throw if elements are not of type T.
        // For more robust parsing of complex lists, you'd iterate and parse each item.
        return List<T>.from(this[key] as List);
      } catch (e) {
        throw FormatException(
          "Key '$key' contains a List, but its elements could not be cast to type '$T': ${e.toString()}",
        );
      }
    }
    throw FormatException("Key '$key' not found or not a List in JSON map.");
  }

  /// Attempts to parse the value of the specified [key] as a [Map<String, dynamic>].
  /// Returns [defaultValue] if the key does not exist or the value is not a Map.
  Map<String, dynamic>? getMap(
    String key, {
    Map<String, dynamic>? defaultValue,
  }) {
    if (containsKey(key) && this[key] is Map<String, dynamic>) {
      return this[key] as Map<String, dynamic>?;
    }
    return defaultValue;
  }

  /// Parses the value of the specified [key] as a [Map<String, dynamic>].
  /// Throws a [FormatException] if the key does not exist or the value is not a Map.
  Map<String, dynamic> getMapOrThrow(String key) {
    if (containsKey(key) && this[key] is Map<String, dynamic>) {
      return this[key] as Map<String, dynamic>;
    }
    throw FormatException(
      "Key '$key' not found or not a Map<String, dynamic> in JSON map.",
    );
  }

  /// Attempts to parse the value of the specified [key] as a [DateTime].
  /// Assumes the string value is in a format parseable by DateTime.parse() (e.g., ISO 8601).
  /// Returns [defaultValue] if the key does not exist or the value cannot be parsed as a DateTime.
  DateTime? getDateTime(String key, {DateTime? defaultValue}) {
    if (containsKey(key) && this[key] is String) {
      try {
        return DateTime.parse(this[key] as String);
      } catch (e) {
        // Could log the parsing error if needed
        // print("Error parsing DateTime for key '$key': ${this[key]}, error: $e");
        return defaultValue;
      }
    }
    return defaultValue;
  }

  /// Parses the value of the specified [key] as a [DateTime].
  /// Assumes the string value is in a format parseable by DateTime.parse() (e.g., ISO 8601).
  /// Throws a [FormatException] if the key does not exist, the value is not a String,
  /// or the String cannot be parsed as a DateTime.
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

  /// Attempts to parse the value of the specified [key] as a [DateTime] using a specific [format].
  /// Returns [defaultValue] if the key does not exist, the value cannot be parsed, or is not a String.
  /// Requires the 'intl' package.
  DateTime? getDateTimeWithFormat(
    String key,
    DateFormat format, {
    DateTime? defaultValue,
  }) {
    if (containsKey(key) && this[key] is String) {
      try {
        return format.parse(this[key] as String);
      } catch (e) {
        // print("Error parsing DateTime with format for key '$key': ${this[key]}, error: $e");
        return defaultValue;
      }
    }
    return defaultValue;
  }

  /// Parses the value of the specified [key] as a [DateTime] using a specific [format].
  /// Throws a [FormatException] if the key does not exist, the value is not a String,
  /// or the String cannot be parsed using the given [format].
  /// Requires the 'intl' package.
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
