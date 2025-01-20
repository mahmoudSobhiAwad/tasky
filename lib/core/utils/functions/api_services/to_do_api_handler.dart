import 'package:dio/dio.dart';
import 'package:tasky/core/utils/functions/api_services/api_handler.dart';

class ApiHandlerImp implements ApiHandler {
  final Dio dio;
  ApiHandlerImp({required this.dio});
  @override
  Future delete(String? url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String? url,
      {Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    final result = await dio.get(
      url ?? dio.options.baseUrl,
      queryParameters: queryParameter,
      options: Options(
        headers: headers,
      ),
    );
    return result;
  }

  @override
  Future post(String? url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future put(String? url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
