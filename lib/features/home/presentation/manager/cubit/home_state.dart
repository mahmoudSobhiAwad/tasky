part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LogOutLoadingState extends HomeState {}

final class LogOutFailureState extends HomeState {
  final String? errMessage;
  LogOutFailureState({this.errMessage});
}

final class LogOutSuccessState extends HomeState {}
