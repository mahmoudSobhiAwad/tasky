import 'package:dio/dio.dart';
import 'package:tasky/core/utils/functions/api_services/api_handler.dart';

class PhoneValidationApi extends ApiHandler {
  final Dio dio;
  PhoneValidationApi({required this.dio});
  @override
  Future get(String url,
      {Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    final result = await dio.get(
      dio.options.baseUrl,
      queryParameters: queryParameter,
      options: Options(
        headers: headers,
      ),
    );
    return result;
  }
}
