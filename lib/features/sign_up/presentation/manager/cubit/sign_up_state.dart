part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpCubitInitial extends SignUpState {}

final class PhoneValidationLoadingState extends SignUpState {}

final class PhoneValidationSuccessState extends SignUpState {}

final class PhoneValidationFailureState extends SignUpState {
  final String? errMessage;

  PhoneValidationFailureState({this.errMessage});
}

final class PhoneValidationLoadingState extends SignUpState {}

final class PhoneValidationSuccessState extends SignUpState {}

final class PhoneValidationFailureState extends SignUpState {
  final String? errMessage;

  PhoneValidationFailureState({this.errMessage});
}
