import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/features/login/domain/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final ApiHandlerImp apiHandlerImp;
  HomeRepoImp({required this.apiHandlerImp});
  @override
  Future<Either<Failure, bool>> logOut({required String refreshToken}) async {
    try {
      final result =
          await apiHandlerImp.post('logout', body: {"token": refreshToken});
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
}
