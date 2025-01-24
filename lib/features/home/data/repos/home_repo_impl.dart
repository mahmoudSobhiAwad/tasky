import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/features/create_edit_task/data/models/task_model.dart';
import 'package:tasky/features/home/domain/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final ApiHandlerImp apiHandlerImp;
  HomeRepoImp({required this.apiHandlerImp});
  @override
  Future<Either<Failure, bool>> logOut({required String refreshToken}) async {
    try {
      final result = await apiHandlerImp
          .post('auth/logout', body: {"token": refreshToken});
      if (result.statusCode == 201) {
        return right(result.data['success'] as bool);
      }
      return left(ServerFailure(errMessage: 'Error Due To Parsing'));
    } catch (e) {
      return e is DioException
          ? left(ServerFailure.fromDioError(e))
          : left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks(int pageNum,
      {String? filterType}) async {
    try {
      List<TaskModel> tasksList = [];
      final result = await apiHandlerImp.get('todos', queryParameter: {
        'page': pageNum,
        if (filterType != null) 'status': filterType,
      });
      for (var item in result.data) {
        tasksList.add(TaskModel.fromJson(item));
      }
      return right(tasksList);
    } catch (e) {
      return left(e is DioException
          ? ServerFailure.fromDioError(e)
          : ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> deleteTask(
      {required String taskId}) async {
    try {
      final result = await apiHandlerImp.delete('todos/$taskId');
      if (result.statusCode == 200) {
        return right(TaskModel.fromJson(result.data));
      }
      return left(ServerFailure(errMessage: 'Error in Parsing'));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModel>> getOneTask(
      {required String qrCodeId}) async {
    try {
      final result = await apiHandlerImp.get('todos/$qrCodeId');
      if (result.statusCode == 200) {
        return right(TaskModel.fromJson(result.data));
      }
      return left(ServerFailure(errMessage: 'Error in Parsing'));
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
