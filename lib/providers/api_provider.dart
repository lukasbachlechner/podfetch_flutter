import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final apiProvider = Provider<PodfetchApiProvider>((ref) {
  final dio = getDio();

  return PodfetchLegacyProvider(dio, baseUrl: 'http://localhost:3333/v1/');
});

final categoriesProvider = Provider<PodfetchStaticCategoriesRepository>((ref) {
  return PodfetchStaticCategoriesRepository();
});

Dio getDio() {
  final dio = Dio();
  const storage = FlutterSecureStorage();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final authToken = await storage.read(key: 'api-token');
      if (authToken != null) {
        options.headers['Authorization'] = 'Bearer $authToken';
      }
      return handler.next(options);
    },
  ));

  dio.interceptors.add(PrettyDioLogger(
    responseBody: false,
    requestHeader: false,
    requestBody: false,
    request: true,
  ));

  dio.interceptors.add(DioCacheManager(
    CacheConfig(baseUrl: 'http://localhost:3333', defaultRequestMethod: 'GET'),
  ).interceptor);

  return dio;
}
