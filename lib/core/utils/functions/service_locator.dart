import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tasky/core/utils/functions/api_services/dio_interceptor.dart';
import 'package:tasky/core/utils/functions/api_services/phone_validation_api_imp.dart';
import 'package:tasky/core/utils/functions/api_services/to_do_api_handler.dart';
import 'package:tasky/features/create_edit_task/data/repos/add_edit_task_repo_impl.dart';
import 'package:tasky/features/home/data/repos/home_repo_impl.dart';
import 'package:tasky/features/sign_up/data/repos/phone_validation_repo_imp.dart';

final GetIt getIt = GetIt.instance;
Future<void> setUp() async {
  getIt.registerSingleton(Dio(
    BaseOptions(
      baseUrl: 'https://todo.iraqsapp.com/',
      connectTimeout: Duration(seconds: 45),
      receiveTimeout: Duration(seconds: 45),
    ),
  ));
  getIt.registerSingleton<ApiHandlerImp>(ApiHandlerImp(
      dio: getIt.get<Dio>()
        ..interceptors.add(CustomInterceptors(dio: getIt.get<Dio>()))));
  getIt.registerLazySingleton(() => PhoneValidationApiImpl(
          dio: Dio(
        BaseOptions(
          baseUrl: 'https://phonevalidation.abstractapi.com/v1/',
          connectTimeout: Duration(seconds: 45),
          receiveTimeout: Duration(seconds: 45),
        ),
      )));
  getIt.registerLazySingleton(() => PhoneValidationRepoImp(
      phoneValidationImp: getIt.get<PhoneValidationApiImpl>()));
  getIt.registerLazySingleton(
      () => HomeRepoImp(apiHandlerImp: getIt.get<ApiHandlerImp>()));

  getIt.registerLazySingleton(
      () => AddEditTaskRepoImpl(apiHandlerImp: getIt.get<ApiHandlerImp>()));
}
