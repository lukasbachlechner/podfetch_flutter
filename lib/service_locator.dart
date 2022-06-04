import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final getIt = GetIt.instance;

void setupLocators() {
  getIt.registerLazySingleton<PodfetchApiProvider>(() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      // responseBody: true,
      requestBody: true,
    ));
    return PodfetchLegacyProvider(dio, baseUrl: 'http://localhost:3333/v1/');
  });

  getIt.registerLazySingleton<PodfetchStaticCategoriesRepository>(() {
    return PodfetchStaticCategoriesRepository();
  });
}
