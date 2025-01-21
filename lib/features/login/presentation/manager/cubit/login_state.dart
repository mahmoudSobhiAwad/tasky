part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class ChangeCounrtyPickedState extends LoginState {
  final Country country;

  ChangeCounrtyPickedState({required this.country});
}

final class ChangeVisibilityState extends LoginState {
  final bool value;

  ChangeVisibilityState({required this.value});
}

class LoginProccessState extends LoginState {}

final class LoginLoadingState extends LoginProccessState {}

final class LoginSuccessState extends LoginProccessState {}

final class LoginFailureState extends LoginProccessState {
  final String? errMessage;

  LoginFailureState({this.errMessage});
}
