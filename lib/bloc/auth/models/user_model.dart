import '../../../extensions/json_parser_extensions.dart';

/// Simple immutable user domain model used by the authentication layer.
///
/// This model is intentionally minimal and focuses on the user attributes
/// required by the UI and routing logic.
///
/// Serialization:
/// - Use [UserModel.fromJson] to construct from a JSON-like map.
/// - Use [toJson] to convert the model back into a map.
///
/// Note:
/// Parsing is strict via `getStringOrThrow(...)` and will throw a [FormatException]
/// if required keys are missing or have an unexpected type.
class UserModel {
  /// Unique identifier of the user (e.g. personnel number).
  final String id;

  /// First name / given name.
  final String firstName;

  /// Last name / family name.
  final String lastName;

  /// E-mail address of the user.
  final String email;

  /// Creates an immutable [UserModel].
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  /// Creates a [UserModel] from a JSON-like map.
  ///
  /// Required keys:
  /// - `id`
  /// - `firstName`
  /// - `lastName`
  /// - `email`
  ///
  /// Throws:
  /// - [FormatException] if a required key is missing or not a string.
  UserModel.fromJson(Map<String, dynamic> json)
      : id = json.getStringOrThrow('id'),
        firstName = json.getStringOrThrow('firstName'),
        lastName = json.getStringOrThrow('lastName'),
        email = json.getStringOrThrow('email');

  /// Converts this model into a JSON-serializable map.
  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
  };
}