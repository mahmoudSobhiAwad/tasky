part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChangeFabVisibilityState extends HomeState {
  final bool isFabVisible;

  ChangeFabVisibilityState({required this.isFabVisible});
}

final class ChangeFilterTypeState extends HomeState {}

final class LogOutLoadingState extends HomeState {}

final class LogOutFailureState extends HomeState {
  final String? errMessage;
  LogOutFailureState({this.errMessage});
}

final class RefreshFailedState extends HomeState {}

final class LogOutSuccessState extends HomeState {}

final class TaskState extends HomeState {}

final class GetAllTasksLoadingState extends TaskState {}

final class GetAllTasksSuccessState extends TaskState {
  GetAllTasksSuccessState();
}

final class GetAllTasksFailureState extends TaskState {
  final String? errMessage;

  GetAllTasksFailureState({this.errMessage});
}

final class FetchMoreLoadingState extends TaskState {}

final class DeleteTaskSuccessState extends TaskState {}

final class DeleteTaskLoadingState extends HomeState {}

final class DeleteTaskFailureState extends HomeState {
  final String? errMessage;

  DeleteTaskFailureState({this.errMessage});
}

final class ScanQrCodeState extends HomeState {}

final class GetOneTaskLoadingState extends HomeState {}

final class GetOneTaskFailureState extends HomeState {
  final String? errMessage;

  GetOneTaskFailureState({this.errMessage});
}

final class GetOneTaskSuccessState extends HomeState {
  final TaskModel taskModel;

  GetOneTaskSuccessState({required this.taskModel});
}
