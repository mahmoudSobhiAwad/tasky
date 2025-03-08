part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpCubitInitial extends SignUpState {}

final class ChangeVisibiltyOfPasswordState extends SignUpState {
  final bool value;

  ChangeVisibiltyOfPasswordState({required this.value});
}

final class ChangeCountryCodeState extends SignUpState {
  final String country;

  ChangeCountryCodeState({required this.country});
}

final class ChangeExperienceLevelState extends SignUpState {
  final String value;
  ChangeExperienceLevelState({required this.value});
}

final class PhoneValidationLoadingState extends SignUpState {}

final class PhoneValidationSuccessState extends SignUpState {}

final class PhoneValidationFailureState extends SignUpState {
  final String? errMessage;

  PhoneValidationFailureState({this.errMessage});
}

final class SignUpLoadingState extends SignUpState {}

final class SignUpSuccessState extends SignUpState {}

final class SignUpFailureState extends SignUpState {
  final String? errMessage;

  SignUpFailureState({this.errMessage});
}
