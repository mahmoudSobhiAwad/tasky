import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/database/api/api_consumer.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
import 'package:tasky/features/login/data/repos/login_repo_imp.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiHandlerImp apiHandlerImp;
  LoginCubit({required this.apiHandlerImp}) : super(LoginInitial());
  Future<void> login(
      {required String phoneNumber, required String passowrd}) async {
    emit(LoginLoadingState());
    final result = await LoginRepoImp(apiHandlerImp: apiHandlerImp)
        .login(phoneNuber: phoneNumber, passowrd: passowrd);
    result.fold((error) {
      emit(LoginFailureState(errMessage: error.errMessage));
    }, (userModel) async {
      await SecureSharedPref.putValue(
          key: accessTokenParam, value: userModel.accessToken);
      await SecureSharedPref.putValue(
          key: refreshTokenParam, value: userModel.refreshToken);
      emit(LoginSuccessState());
    });
  }

  void changePasswordVisibility(
    bool value,
  ) {
    emit(ChangeVisibilityState(value: !value));
  }
}
