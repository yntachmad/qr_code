part of 'auth_bloc.dart';

sealed class AuthEvent {}

//Event -> action (Trigger menjalankan fungsi)
// 1. AuthEventLogin -> melakukan Login
// 2. AuthEventLogout -> melakukan Login

final class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogin({required this.email, required this.password});
}

final class AuthEventLogout extends AuthEvent {}
