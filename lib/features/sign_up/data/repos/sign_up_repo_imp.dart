import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/features/sign_up/data/models/create_acc_model.dart';
import 'package:tasky/features/sign_up/data/models/user_sign_up_model.dart';
import 'package:tasky/features/sign_up/domain/repo/sign_up_repo.dart';

class SignUpRepoImp implements SignUpRepo {
  final ApiHandlerImp apiHandlerImp;
  SignUpRepoImp({required this.apiHandlerImp});
  @override
  Future<Either<Failure, UserSignAuthModel>> createAccount(
      {required CreateAccountModel createAccModel}) async {
    try {
      final result = await apiHandlerImp.post('auth/register',
          body: createAccModel.toJson());

      if (result.statusCode == 201) {
        return right(UserSignAuthModel.fromJson(result.data));
      }
      return left(ServerFailure(errMessage: 'Error in Parsing'));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
