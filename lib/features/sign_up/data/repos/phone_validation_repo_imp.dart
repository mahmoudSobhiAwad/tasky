import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/features/sign_up/data/models/phone_validation_model/phone_validation_model.dart';
import 'package:tasky/features/sign_up/domain/repo/phone_validation_repo.dart';

class PhoneValidationRepoImp implements PhoneValidationRepo {
  @override
  Future<Either<Failure, PhoneValidationModel>> validate() async {
    try {


    } catch (e) {

    }
  }
}
