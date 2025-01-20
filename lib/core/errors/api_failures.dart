import 'package:dio/dio.dart';

abstract class Failure {
  final String? errMessage;
  final int? statusCode;
  const Failure({this.errMessage, this.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure({super.errMessage, super.statusCode});

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioException.connectionTimeout:
        return ServerFailure(
          errMessage: 'Connection timeout with ApiServer',
        );

      case DioException.sendTimeout:
        return ServerFailure(errMessage: 'Send timeout with ApiServer');

      case DioException.receiveTimeout:
        return ServerFailure(
          errMessage: 'Receive timeout with ApiServer',
        );
      case DioException.badResponse:
        return ServerFailure.fromResponse(
            dioError.response?.statusCode, dioError.response?.data);
      case DioException.requestCancelled:
        return ServerFailure(errMessage: 'Request to ApiServer was cancelled');
      default:
        return ServerFailure.fromResponse(
            dioError.response?.statusCode, dioError.response?.data);
    }
  }

  factory ServerFailure.fromResponse(
      int? statusCode, Map<String, dynamic> data) {
    if (statusCode == 403) {
      return ServerFailure(errMessage: data['message']);
    } else if (statusCode == 401) {
      return ServerFailure(errMessage: data['message'], statusCode: 401);
    } 
    else if (statusCode == 422) {
      return ServerFailure(errMessage: data['message'], statusCode: 422);
    }
    else {
      return ServerFailure(
          errMessage: "Server may be not exist at that moment",
          statusCode: statusCode);
    }
  }
}
