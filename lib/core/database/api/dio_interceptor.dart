import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tasky/core/database/api/refresh_token.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';

class CustomInterceptors extends Interceptor {
  final Dio dio;

  CustomInterceptors({required this.dio});
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken =
        await SecureSharedPref.getValues(key: accessTokenParam);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    log('REQUEST[${options.method}] => PATH: ${options.path}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE is [${response.data}] => PATH: ${response.requestOptions.path}');
    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log('ERROR code is :[${err.response?.statusCode}] => PATH: ${err.response?.data}');
    if (err.response?.statusCode == 401) {
      final String? newAccessToken = await refreshToken();
      if (newAccessToken != null) {
        await SecureSharedPref.putValue(
            key: accessTokenParam, value: newAccessToken);
        err.requestOptions.headers['Authorization'] = 'bearer $newAccessToken';

        dynamic data = err.requestOptions.data;
        if (data is FormData) {
          final newFormData = FormData();

          for (var field in data.fields) {
            newFormData.fields.add(field);
          }

          for (var file in data.files) {
            final originalFilePath = data.fields
                .firstWhere(
                  (field) => field.key == '_originalFilePath',
                  orElse: () => MapEntry('key', ''),
                )
                .value;

            if (originalFilePath.isNotEmpty) {
              final newMultipartFile = await MultipartFile.fromFile(
                originalFilePath,
                filename: file.value.filename,
                contentType: file.value.contentType,
              );
              newFormData.files.add(MapEntry(file.key, newMultipartFile));
            } else {
              throw Exception("Original file path not found for MultipartFile");
            }
          }

          data = newFormData;
        }

        var clonedRequest = await dio.request(
          err.requestOptions.path,
          queryParameters: err.requestOptions.queryParameters,
          data: data,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
        );

        return handler.resolve(clonedRequest);
      }
    }
    if (err.response?.statusCode == 422) {
      return handler.next(err);
    }
    super.onError(err, handler);
  }
}


