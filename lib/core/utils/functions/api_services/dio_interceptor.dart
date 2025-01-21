import 'dart:developer';

import 'package:dio/dio.dart';
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
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final clonedRequest = await dio.request(err.requestOptions.path,
            queryParameters: err.requestOptions.queryParameters,
            data: err.requestOptions.data,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ));
        return handler.resolve(clonedRequest);
      }
    }
    super.onError(err, handler);
  }
}

Future<String?> refreshToken() async {
  final Dio dio = Dio();
  String? refreshToken =
      await SecureSharedPref.getValues(key: refreshTokenParam);
  if (refreshToken != null) {
    try {
      final result = await dio.get(
          'https://todo.iraqsapp.com/auth/refresh-token',
          queryParameters: {
            'token': refreshToken,
          });
      if (result.statusCode == 200) {
        return result.data['access_token'] as String;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  return null;
}
