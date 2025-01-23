import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/features/profile/data/model/profile_model.dart';
import 'package:tasky/features/profile/domain/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ApiHandlerImp apiHandlerImp;

  ProfileRepoImpl({required this.apiHandlerImp});
  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final result = await apiHandlerImp.get('auth/profile');
      if (result.statusCode == 200) {
        return right(ProfileModel.fromJson(result.data));
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
