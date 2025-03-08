import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/database/api/api_consumer.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
import 'package:tasky/features/sign_up/data/models/create_acc_model.dart';
import 'package:tasky/features/sign_up/data/repos/sign_up_repo_imp.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final ApiHandlerImp apiHandlerImp;
  SignUpCubit({
    required this.apiHandlerImp,
  }) : super(SignUpCubitInitial());

  Future<void> createAccount(CreateAccountModel model) async {
    final result = await SignUpRepoImp(apiHandlerImp: apiHandlerImp)
        .createAccount(createAccModel: model);
    result.fold((error) {
      emit(SignUpFailureState(errMessage: error.errMessage));
    }, (userModel) async {
      await SecureSharedPref.putValue(
          key: accessTokenParam, value: userModel.accessToken);
      await SecureSharedPref.putValue(
          key: refreshTokenParam, value: userModel.refreshToken);
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
    
  ) {
    emit(ChangeCountryCodeState(country: 'value'));
  }
}
