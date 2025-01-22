import 'package:dio/dio.dart';

abstract class ApiHandler {
  Future<Response> get(String endPoint,
      {String? url,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers});
  Future<Response> post(String endPoint,
      {String? url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers});

  Future<Response> put(String endPoint,
      {String? url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers});
  Future<Response> delete(String endPoint,
      {String? url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers});
}
