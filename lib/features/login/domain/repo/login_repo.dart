import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/features/sign_up/data/models/user_sign_up_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserSignAuthModel>> login(
      {required String phoneNuber, required String passowrd});
}
