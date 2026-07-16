import 'package:m_store_1/feature/auth/data/model/user_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class GetProfileLoadingState extends ProfileState {}

class GetProfileSuccessState extends ProfileState {
  final UserModel user;

  GetProfileSuccessState(this.user);
}

class GetProfileErrorState extends ProfileState {
  final String message;

  GetProfileErrorState(this.message);
}

class LogoutLoadingState extends ProfileState {}

class LogoutSuccessState extends ProfileState {}

class LogoutErrorState extends ProfileState {
  final String message;

  LogoutErrorState(this.message);
}