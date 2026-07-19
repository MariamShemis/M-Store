import 'package:m_store_1/feature/main_layout/home/data/model/home_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeModel home;

  HomeSuccess(this.home);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}