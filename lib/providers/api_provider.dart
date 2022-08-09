import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers.dart';

Dio getDio({required ProviderRef ref}) {
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

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.queryParameters.addAll({
        'lang': ref.watch(languageProvider).isoCode,
      });
      return handler.next(options);
    },
  ));

  /* dio.interceptors.add(PrettyDioLogger(
    responseBody: true,
    requestHeader: false,
    requestBody: true,
    request: true,
  )); */

  return dio;
}
