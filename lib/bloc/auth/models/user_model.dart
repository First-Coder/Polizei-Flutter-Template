import '../../../extensions/json_parser_extensions.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : id = json.getStringOrThrow('id'),
      firstName = json.getStringOrThrow('firstName'),
      lastName = json.getStringOrThrow('lastName'),
      email = json.getStringOrThrow('email');

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
  };
}
