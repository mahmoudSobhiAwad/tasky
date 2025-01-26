import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tasky/features/home/data/repos/home_repo_impl.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit({required this.homeRepoImp}) : super(TaskDetailsInitial());
  final HomeRepoImp homeRepoImp;
  Future<void> deleteTask(String? taskId) async {
    if (taskId != null) {
      emit(LoadingDeleteTask());
      final result = await homeRepoImp.deleteTask(taskId: taskId);
      result.fold((error) {
        emit(FailureDeleteTask(errMessage: error.errMessage));
      }, (task) {
        emit(SuccessDeleteTask(taskId: taskId));
      });
    }
  }
}
