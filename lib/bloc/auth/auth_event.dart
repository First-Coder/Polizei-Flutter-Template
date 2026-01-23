part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoadAuthentication extends AuthEvent {}

class ReloadAuthentication extends AuthEvent {}

class Login extends AuthEvent {}
