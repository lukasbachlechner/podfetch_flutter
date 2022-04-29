import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_api/providers/api_provider.dart';

final getIt = GetIt.instance;

void setupLocators() {
  getIt.registerLazySingleton<PodfetchApiProvider>(() {
    final _dio = Dio();
    return PodfetchLegacyProvider(_dio);
  });

  getIt.registerLazySingleton<PodfetchStaticCategoriesRepository>(() {
    return PodfetchStaticCategoriesRepository();
  });
}
