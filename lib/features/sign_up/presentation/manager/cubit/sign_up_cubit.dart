import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
import 'package:tasky/features/sign_up/data/models/create_acc_model.dart';
import 'package:tasky/features/sign_up/data/repos/phone_validation_repo_imp.dart';
import 'package:tasky/features/sign_up/data/repos/sign_up_repo_imp.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final PhoneValidationRepoImp phoneValidationRepoImp;
  final ApiHandlerImp apiHandlerImp;
  SignUpCubit(
      {required this.apiHandlerImp, required this.phoneValidationRepoImp})
      : super(SignUpCubitInitial());

  Future<void> validatePhoneNumber({required CreateAccountModel model}) async {
    emit(PhoneValidationLoadingState());
    String phoneNumberWithCode = model.phone;
    final result = await phoneValidationRepoImp.validate(phoneNumberWithCode);
    result.fold((error) {
      emit(PhoneValidationFailureState(errMessage: error.errMessage));
    }, (phoneModel) async {
      if (phoneModel.valid) {
        await createAccount(model);
      } else {
        emit(PhoneValidationFailureState(
            errMessage: 'Phone Validation Failed !!'));
      }
    });
  }

  Future<void> createAccount(CreateAccountModel model) async {
    emit(SignUpLoadingState());
    final result = await SignUpRepoImp(apiHandlerImp: apiHandlerImp)
        .createAccount(createAccModel: model);
    result.fold((error) {
      emit(SignUpFailureState(errMessage: error.errMessage));
    }, (userModel) async {
      await SecureSharedPref.putValue(key:accessTokenParam ,value: userModel.accessToken);
      await SecureSharedPref.putValue(key:refreshTokenParam ,value: userModel.refreshToken);
      emit(SignUpSuccessState());
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
