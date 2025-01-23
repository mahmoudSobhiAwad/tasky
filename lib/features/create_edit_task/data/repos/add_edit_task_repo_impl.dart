import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/features/create_edit_task/data/models/create_edit_task_model.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
import 'package:tasky/features/create_edit_task/domain/repo/task_repo.dart';

class AddEditTaskRepoImpl implements AddEditTaskRepo {
  final ApiHandlerImp apiHandlerImp;

  AddEditTaskRepoImpl({required this.apiHandlerImp});
  @override
  Future<Either<Failure, TaskModel>> createTask(
      CreateEditTaskModel model) async {
    try {
      final result = await apiHandlerImp.post('todos', body: model.toJson());
      if (result.statusCode == 201) {
        return right(TaskModel.fromJson(result.data));
      }
      return left(ServerFailure(errMessage: 'Error in parsing'));
    } catch (e) {
      return e is DioException
          ? left(ServerFailure.fromDioError(e))
          : left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> editTask(TaskModel model) async {
    try {
      final result =
          await apiHandlerImp.put('todos/${model.id}', body: model.toJson());
      if (result.statusCode == 200) {
        return right(TaskModel.fromJson(result.data));
      }
      return left(ServerFailure(errMessage: 'Error Due Parsing'));
    } catch (e) {
      return e is DioException
          ? left(ServerFailure.fromDioError(e))
          : left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(String imagePath) async {
    try {
      var data = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath,
            filename: imagePath.split('/').last,
            contentType:
                DioMediaType.parse("image/${imagePath.split('.').last}")),
        '_originalFilePath': imagePath,
      });

      var result = await apiHandlerImp.post(
        'upload/image',
        body: data,
      );
      if (result.statusCode == 201) {
        return right(result.data['image'] as String);
      }
      return left(ServerFailure(errMessage: 'Error in parsing'));
    } catch (e) {
      return left(e is DioException
          ? ServerFailure.fromDioError(e)
          : ServerFailure(errMessage: e.toString()));
    }
  }
}
