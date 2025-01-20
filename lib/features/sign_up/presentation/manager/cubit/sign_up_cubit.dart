import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tasky/features/sign_up/data/repos/phone_validation_repo_imp.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final PhoneValidationRepoImp phoneValidationRepoImp;
  SignUpCubit({required this.phoneValidationRepoImp})
      : super(SignUpCubitInitial());

  Future<void> validatePhoneNumber(
      {required String phoneNumber, required String countryCode}) async {
    emit(PhoneValidationLoadingState());
    String phoneNumberWithCode = '$countryCode$phoneNumber';
    final result = await phoneValidationRepoImp.validate(phoneNumberWithCode);
    result.fold((error) {
      emit(PhoneValidationFailureState(errMessage: error.errMessage));
    }, (phoneModel) {
      if (phoneModel.valid) {
        // sign up method impl
        emit(PhoneValidationSuccessState());
      } else {
        emit(PhoneValidationFailureState(
            errMessage: 'Phone Validation Failed !!'));
      }
    });
  }

  void changeSelectedExpereincneLevel(
    String value,
  ) {
    emit(ChangeExperienceLevelState(value: value));
  }

  void changePasswordVisibility(
    bool value,
  ) {
    emit(ChangeVisibiltyOfPasswordState(value: !value));
  }

  void changeCountryPicked(
    Country value,
  ) {
    emit(ChangeCountryCodeState(country: value));
  }
}
