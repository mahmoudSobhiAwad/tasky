import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
import 'package:tasky/features/home/data/repos/home_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImp homeRepoImp;
  HomeCubit({required this.homeRepoImp}) : super(HomeInitial());

  bool _isProcessing = false;

  Future<void> logOut() async {
    if (!_isProcessing) {
      _isProcessing = true;
      String? refreshToken =
          await SecureSharedPref.getValues(key: refreshTokenParam);
      if (refreshToken != null) {
        emit(LogOutLoadingState());
        final result = await homeRepoImp.logOut(refreshToken: refreshToken);
        result.fold((error) {
          error.statusCode == 403
              ? emit(RefreshFailedState())
              : emit(LogOutFailureState(errMessage: error.errMessage));
        }, (success) async {
          await SecureSharedPref.putValue(key: accessTokenParam, value: null);
          await SecureSharedPref.putValue(key: refreshTokenParam, value: null);
          emit(LogOutSuccessState());
        });
      }
      _isProcessing = false;
    }
  }
}
