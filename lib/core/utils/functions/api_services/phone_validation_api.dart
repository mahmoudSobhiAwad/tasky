import 'package:dio/dio.dart';

abstract class PhoneValidationApiService {
  Future<Response> get(
      {String? url,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers});
}
