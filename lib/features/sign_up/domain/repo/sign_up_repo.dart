import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/features/sign_up/data/models/create_acc_model.dart';
import 'package:tasky/features/sign_up/data/models/user_sign_up_model.dart';

abstract class SignUpRepo {
  Future<Either<Failure, UserSignUpModel>> createAccount({required CreateAccountModel createAccModel});
}
