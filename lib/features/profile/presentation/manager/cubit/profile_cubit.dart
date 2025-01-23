import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/features/profile/data/model/profile_model.dart';
import 'package:tasky/features/profile/data/repo/profile_repo_impl.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ApiHandlerImp apiHandlerImp;
  ProfileCubit({required this.apiHandlerImp}) : super(ProfileInitial());
  Future<void> getProfileData() async {
    emit(ProfileLoadingState());
    final result =
        await ProfileRepoImpl(apiHandlerImp: apiHandlerImp).getProfile();
    result.fold((error) {
      emit(ProfileFailureState(errMessage: error.errMessage));
    }, (model) {
      emit(ProfileSuccessState(profileModel: model));
    });
  }
}
