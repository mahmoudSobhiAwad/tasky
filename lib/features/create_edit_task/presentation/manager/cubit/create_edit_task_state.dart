part of 'create_edit_task_cubit.dart';

@immutable
sealed class CreateEditTaskState {}

final class CreateEditTaskInitial extends CreateEditTaskState {}

final class ChangeCurrPictureState extends CreateEditTaskState {
  final ImageModel imageModel;

  ChangeCurrPictureState({required this.imageModel});
}

final class ChangePirorityState extends CreateEditTaskState {}

final class ChangeDueDateState extends CreateEditTaskState {
  final String? date;

  ChangeDueDateState({this.date});
}

final class UploadTaskState extends CreateEditTaskState {}

final class LoadingUploadTaskState extends UploadTaskState {}

final class LoadingUploadImageState extends UploadTaskState {}

final class FailureUploadImageState extends UploadTaskState {
  final String? errMessage;
  FailureUploadImageState({this.errMessage});
}

final class SuccessUploadTaskState extends UploadTaskState {
  final TaskModel taskModel;

  SuccessUploadTaskState({required this.taskModel});
}

final class FailureUploadTaskState extends UploadTaskState {
  final String? errMessage;

  FailureUploadTaskState({this.errMessage});
}
