import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';

final GetIt getIt = GetIt.instance();
Future<void> setUp() async {
  getIt.registerSingleton<ApiHandlerImp>(ApiHandlerImp(
      dio: Dio(
    BaseOptions(
      baseUrl: 'https://todo.iraqsapp.com/',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
    ),
  )));
  getIt.registerLazySingleton(() => ApiHandlerImp(
          dio: Dio(
        BaseOptions(
          baseUrl: 'https://phonevalidation.abstractapi.com/v1/',
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 3),
        ),
      )));
}
