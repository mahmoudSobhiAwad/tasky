part of 'create_edit_task_cubit.dart';

@immutable
sealed class CreateEditTaskState {}

final class CreateEditTaskInitial extends CreateEditTaskState {}

final class ChangeCurrPictureState extends CreateEditTaskState {
  final ImageModel imageModel;

  ChangeCurrPictureState({required this.imageModel});
}

final class ChangePirorityState extends CreateEditTaskState {
  final String? value;

  ChangePirorityState({required this.value});
}

final class ChangeDueDateState extends CreateEditTaskState {
  final String date;

  ChangeDueDateState({required this.date});
}

final class UploadTaskState extends CreateEditTaskState {}

final class LoadingAddTaskState extends UploadTaskState {}

final class LoadingUploadImageState extends UploadTaskState {}

final class FailureUploadImageState extends UploadTaskState {
  final String? errMessage;
  FailureUploadImageState({this.errMessage});
}

final class SuccessAddTaskState extends UploadTaskState {
  final TaskModel taskModel;

  SuccessAddTaskState({required this.taskModel});
}

final class FailureAddTaskState extends UploadTaskState {
  final String? errMessage;

  FailureAddTaskState({this.errMessage});
}
