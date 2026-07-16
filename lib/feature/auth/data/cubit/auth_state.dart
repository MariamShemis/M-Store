import 'package:m_store_1/feature/auth/data/model/user_model.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

/// Register

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String message;

  RegisterErrorState(this.message);
}

/// Login

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final UserModel user;

  LoginSuccessState(this.user);
}

class LoginErrorState extends AuthState {
  final String message;

  LoginErrorState(this.message);
}

/// Reset Password

class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordErrorState extends AuthState {
  final String message;

  ResetPasswordErrorState(this.message);
}

/// Logout

class LogoutLoadingState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class LogoutErrorState extends AuthState {
  final String message;

  LogoutErrorState(this.message);
}
