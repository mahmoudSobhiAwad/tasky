import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/api_failures.dart';
import 'package:tasky/features/profile/data/model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getProfile();
}
