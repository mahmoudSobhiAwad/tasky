import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/core/database/api/dio_interceptor.dart';
import 'package:tasky/core/database/api/api_consumer.dart';
import 'package:tasky/core/utils/constants/var_contstant.dart';
import 'package:tasky/features/create_edit_task/data/repos/add_edit_task_repo_impl.dart';
import 'package:tasky/features/home/data/repos/home_repo_impl.dart';

final GetIt getIt = GetIt.instance;
Future<void> setUp() async {
  getIt.registerSingleton(Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 45),
      receiveTimeout: Duration(seconds: 45),
    ),
  ));
  getIt.registerSingleton<ApiHandlerImp>(ApiHandlerImp(
      dio: getIt.get<Dio>()
        ..interceptors.add(CustomInterceptors(dio: getIt.get<Dio>()))));

  getIt.registerLazySingleton(
      () => HomeRepoImp(apiHandlerImp: getIt.get<ApiHandlerImp>()));

  getIt.registerLazySingleton(
      () => AddEditTaskRepoImpl(apiHandlerImp: getIt.get<ApiHandlerImp>()));
}
