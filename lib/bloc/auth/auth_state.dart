part of 'auth_bloc.dart';

sealed class AuthState {}

//state -> kondisi saat ini
//AuthStateLoading -> Loading..
// AuthStateLogin -> sedang terauthentikasi
// AuthStateLogout -> tidak terauthentikasi
//AuthStateError -> Error.

final class AuthInitial extends AuthState {}

final class AuthStateLoading extends AuthState {}

final class AuthStateLogin extends AuthState {}

final class AuthStateLogout extends AuthState {}

final class AuthStateError extends AuthState {
  final String messages;

  AuthStateError(this.messages);
}
