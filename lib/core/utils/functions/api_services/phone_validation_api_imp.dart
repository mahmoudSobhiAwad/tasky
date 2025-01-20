import 'package:dio/dio.dart';
import 'package:tasky/core/utils/functions/api_services/phone_validation_api.dart';

class PhoneValidationApiImpl extends PhoneValidationApiService {
  final Dio dio;
  PhoneValidationApiImpl({required this.dio});
  @override
  Future<Response> get(
      {String? url,
      Map<String, dynamic>? queryParameter,
      Map<String, dynamic>? headers}) async {
    final result = await dio.get(
      url ?? dio.options.baseUrl,
      queryParameters: queryParameter,
    );
    return result;
  }
}
