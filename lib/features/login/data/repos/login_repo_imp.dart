import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/features/login/domain/repo/login_repo.dart';
import 'package:tasky/features/sign_up/data/models/user_sign_up_model.dart';

class LoginRepoImp implements LoginRepo {
  final ApiHandlerImp apiHandlerImp;

  LoginRepoImp({required this.apiHandlerImp});
  @override
  Future<Either<Failure, UserSignAuthModel>> login(
      {required String phoneNuber, required String passowrd}) async {
    try {
      final result = await apiHandlerImp.post('auth/login',
          body: {"phone": phoneNuber, "password": passowrd});
      if (result.statusCode == 201) {
        return right(UserSignAuthModel.fromJson(result.data));
      }
      return left(ServerFailure(errMessage: 'Error in Parsing'));
    } catch (e) {
      return e is DioException
          ? left(ServerFailure.fromDioError(e))
          : left(ServerFailure(errMessage: e.toString()));
    }
  }
}
