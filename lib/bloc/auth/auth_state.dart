part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthNotInitialized extends AuthState {}

final class NotAuthorized extends AuthState {
  NotAuthorized({this.error});

  final String? error;
}

final class Authorized extends AuthState {
  Authorized({
    required this.user,
  });

  final UserModel user;
}