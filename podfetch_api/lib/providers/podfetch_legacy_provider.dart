import 'package:dio/dio.dart';
import 'package:podfetch_api/constants.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_api/responses/search_response.dart';
import 'package:retrofit/retrofit.dart';

part 'podfetch_legacy_provider.g.dart';

@RestApi(baseUrl: fullBaseUrl)
abstract class PodfetchLegacyProvider implements PodfetchApiProvider {
  factory PodfetchLegacyProvider(Dio dio, {String baseUrl}) =
      _PodfetchLegacyProvider;

  @override
  @GET('podcasts/trending')
  Future<List<Podcast>> getTrending(
      {@Query('lang') String? language = 'en', @Query('max') int? max = 10});

  @override
  @GET('podcasts/{id}')
  Future<Podcast> getPodcastById(@Path() int id);

  @override
  @GET('search')
  Future<SearchResponse> search(@Query('q') String query);
}
