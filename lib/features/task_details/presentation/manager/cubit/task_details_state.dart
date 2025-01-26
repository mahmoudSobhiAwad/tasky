part of 'task_details_cubit.dart';

@immutable
sealed class TaskDetailsState {}

final class TaskDetailsInitial extends TaskDetailsState {}

final class LoadingDeleteTask extends TaskDetailsState {}

final class SuccessDeleteTask extends TaskDetailsState {
  final String taskId;

  SuccessDeleteTask({required this.taskId});
}

final class FailureDeleteTask extends TaskDetailsState {
  final String? errMessage;

  FailureDeleteTask({this.errMessage});
}
