import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
import 'package:tasky/features/login/data/repos/login_repo_imp.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiHandlerImp apiHandlerImp;
  LoginCubit({required this.apiHandlerImp}) : super(LoginInitial());
  bool _isProcessing = false;
  Future<void> login(
      {required String phoneNuber, required String passowrd}) async {
    if (!_isProcessing) {
      _isProcessing = true;
      emit(LoginLoadingState());
      final result = await LoginRepoImp(apiHandlerImp: apiHandlerImp)
          .login(phoneNuber: phoneNuber, passowrd: passowrd);
      result.fold((error) {
        emit(LoginFailureState(errMessage: error.errMessage));
      }, (userModel) async {
        await SecureSharedPref.putValue(
            key: accessTokenParam, value: userModel.accessToken);
        await SecureSharedPref.putValue(
            key: refreshTokenParam, value: userModel.refreshToken);
        emit(LoginSuccessState());
      });
      _isProcessing = false;
    }
  }

  void changePasswordVisibility(
    bool value,
  ) {
    emit(ChangeVisibilityState(value: !value));
  }

  void changeCountryPicked(
    Country value,
  ) {
    emit(ChangeCounrtyPickedState(country: value));
  }
}
