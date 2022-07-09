import 'package:dio/dio.dart';
import 'package:podfetch_api/constants.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/models/user.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_api/responses/episodes_by_podcast_id_response.dart';
import 'package:podfetch_api/responses/login_response.dart';
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
  Future<Podcast> getPodcastById(@Path() int id,
      {@Query('maxEpisodes') int? maxEpisodes});

  @override
  @GET('podcasts/{id}/episodes')
  Future<EpisodesByPodcastIdResponse> getEpisodesByPodcastId(@Path() int id,
      {@Query('page') int? page = 10, @Query('per_page') int? perPage = 10});

  @override
  @GET('episodes/{id}')
  Future<Episode> getEpisodeById(@Path() int id);

  @override
  @GET('search')
  Future<SearchResponse> search(@Query('q') String query);

  @override
  @POST('auth/login')
  Future<LoginResponse> login(@Body() Map<String, dynamic> json);

  @override
  @POST('auth/logout')
  Future<dynamic> logout({@Header('Authorization') String? bearerToken});

  @override
  @GET('auth/me')
  Future<User> getUser({@Header('Authorization') String? bearerToken});
}
