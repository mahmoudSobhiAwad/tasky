part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileSuccessState extends ProfileState {
  final ProfileModel profileModel;

  ProfileSuccessState({required this.profileModel});
}

final class ProfileFailureState extends ProfileState {
  final String? errMessage;

  ProfileFailureState({this.errMessage});
}
