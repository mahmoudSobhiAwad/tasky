import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, bool>> logOut({required String refreshToken});

  Future<Either<Failure, List<TaskModel>>> getAllTasks(int pageNum);
}
