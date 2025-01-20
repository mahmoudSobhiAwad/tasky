import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/features/sign_up/data/models/phone_validation_model/phone_validation_model.dart';

abstract class PhoneValidationRepo {
  Future<Either<Failure, PhoneValidationModel>> validate(String phoneNumber);
}
