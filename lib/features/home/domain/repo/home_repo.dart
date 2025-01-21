import 'package:dartz/dartz.dart';
import 'package:tasky/core/errors/api_failures.dart';

abstract class HomeRepo {
  Future<Either<Failure, bool>> logOut({required String refreshToken});
}
