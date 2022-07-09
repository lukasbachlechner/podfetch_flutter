import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/providers/language_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final apiProvider = Provider<PodfetchApiProvider>((ref) {
  final dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final auth = ref.watch(authProvider);
      if (auth.token != null) {
        options.headers['Authorization'] = 'Bearer ${auth.token}';
      }
      return handler.next(options);
    },
  ));

  dio.interceptors.add(PrettyDioLogger(
    responseBody: false,
    requestHeader: true,
    request: false,
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.queryParameters.addAll({
        'lang': ref.watch(languageProvider).isoCode,
      });
      return handler.next(options);
    },
  ));

  dio.interceptors.add(DioCacheManager(
    CacheConfig(baseUrl: 'http://localhost:3333', defaultRequestMethod: 'GET'),
  ).interceptor);
  return PodfetchLegacyProvider(dio, baseUrl: 'http://localhost:3333/v1/');
});

final categoriesProvider = Provider<PodfetchStaticCategoriesRepository>((ref) {
  return PodfetchStaticCategoriesRepository();
});
