import 'package:dio/dio.dart';
import 'package:tasky/core/database/api/dio_conusmer.dart';

class ApiHandlerImp implements ApiHandler {
  final Dio dio;
  ApiHandlerImp({required this.dio});

  @override
  Future<Response> delete(String endPoint,
      {String? url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    final result = await dio.delete('${dio.options.baseUrl}$endPoint',
        data: body,
        queryParameters: queryParameter,
        options: Options(
          headers: headers,
        ));
    return result;
  }

  @override
  Future<Response> get(String endPoint,
      {String? url,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    final result = await dio.get('${dio.options.baseUrl}$endPoint',
        queryParameters: queryParameter,
        options: Options(
          headers: headers,
        ));
    return result;
  }

  @override
  Future<Response> post(String endPoint,
      {String? url,
      Object? body,
      String? contentType,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    final result = await dio.post('${dio.options.baseUrl}$endPoint',
        data: body,
        queryParameters: queryParameter,
        options: Options(
          sendTimeout: dio.options.sendTimeout,
          receiveTimeout: dio.options.receiveTimeout,
          contentType: contentType,
          headers: headers,
        ));
    return result;
  }

  @override
  Future<Response> put(String endPoint,
      {String? url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    final result = await dio.put('${dio.options.baseUrl}$endPoint',
        data: body,
        queryParameters: queryParameter,
        options: Options(
          headers: headers,
        ));
    return result;
  }
}
