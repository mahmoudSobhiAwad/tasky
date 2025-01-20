import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/core/utils/constants/api_keys.dart';
import 'package:tasky/core/utils/functions/api_services/phone_validation_api_imp.dart';
import 'package:tasky/features/sign_up/data/models/phone_validation_model/phone_validation_model.dart';
import 'package:tasky/features/sign_up/domain/repo/phone_validation_repo.dart';

class PhoneValidationRepoImp implements PhoneValidationRepo {
  final PhoneValidationApiImpl phoneValidationImp;

  PhoneValidationRepoImp({required this.phoneValidationImp});
  @override
  Future<Either<Failure, PhoneValidationModel>> validate(
      String phoneNumber) async {
    try {
      final result = await phoneValidationImp.get(queryParameter: {
        'phone': phoneNumber,
        'api_key': ApiKeys.phoneValidationApiKey
      });
      if (result.statusCode == 200) {
        return right(PhoneValidationModel.fromMap(result.data));
      }
      return left(ServerFailure(errMessage: 'error in parsing'));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
