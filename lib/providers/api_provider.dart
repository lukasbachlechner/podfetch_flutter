import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_api/providers/podfetch_legacy_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final apiProvider = Provider<PodfetchApiProvider>((ref) {
  final dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
    // responseBody: true,
    requestBody: true,
  ));
  return PodfetchLegacyProvider(dio, baseUrl: 'http://localhost:3333/v1/');
});
