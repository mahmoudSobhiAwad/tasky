import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/features/create_edit_task/data/models/create_edit_task_model.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';

abstract class AddEditTaskRepo {
  Future<Either<Failure, String>> uploadImage(String imagePath);
  Future<Either<Failure, TaskModel>> createTask(CreateEditTaskModel model);
  Future<Either<Failure, TaskModel>> editTask(CreateEditTaskModel model);
}
