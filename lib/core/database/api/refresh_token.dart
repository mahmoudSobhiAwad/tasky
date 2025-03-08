import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/core/utils/functions/secure_shared_pref.dart';
Future<String?> refreshToken() async {
  final Dio dio = Dio();
  String? refreshToken =
      await SecureSharedPref.getValues(key: refreshTokenParam);
  if (refreshToken != null) {
    try {
      final result = await dio.get(
          '${baseUrl}auth/refresh-token',
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