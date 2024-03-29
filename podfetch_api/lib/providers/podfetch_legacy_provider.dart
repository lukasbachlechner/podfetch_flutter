import 'package:dio/dio.dart';
import 'package:podfetch_api/constants.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/liked_episode.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/models/user.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_api/requests/signup_request.dart';
import 'package:podfetch_api/responses/check_email_response.dart';
import 'package:podfetch_api/responses/episodes_by_podcast_id_response.dart';
import 'package:podfetch_api/responses/last_played_response.dart';
import 'package:podfetch_api/responses/login_response.dart';
import 'package:podfetch_api/responses/search_response.dart';
import 'package:retrofit/retrofit.dart';

import '../models/subscribed_podcast.dart';

part 'podfetch_legacy_provider.g.dart';

@RestApi(baseUrl: fullBaseUrl)
abstract class PodfetchLegacyProvider implements PodfetchApiProvider {
  factory PodfetchLegacyProvider(Dio dio, {String baseUrl}) =
      _PodfetchLegacyProvider;

  @override
  @GET('podcasts/trending')
  Future<List<Podcast>> getTrending({
    @Query('lang') String? language = 'en',
    @Query('max') int? max = 10,
    @Query('cat') String? categories,
  });

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
  @GET('auth/check-email')
  Future<CheckEmailResponse> checkEmail(@Query('email') String email);

  @override
  @POST('auth/register')
  Future<User> signUp(@Body() SignupRequest signupRequest);

  @override
  @POST('auth/logout')
  Future<dynamic> logout({@Header('Authorization') String? bearerToken});

  @override
  @GET('auth/me')
  Future<User> getUser({@Header('Authorization') String? bearerToken});

  @override
  @POST('subscriptions/subscribe')
  Future<SubscribedPodcast> subscribeToPodcast({
    @Body() required SubscribedPodcast podcastToSubscribe,
  });

  @override
  @DELETE('subscriptions/unsubscribe')
  Future<void> unsubscribeFromPodcast({
    @Body() required SubscribedPodcast podcastToUnsubscribe,
  });

  @override
  @GET('user/last-playback-no-empty')
  Future<LastPlayedResponse> getLastPlayedEpisode();

  @override
  @GET('user/liked')
  Future<List<Episode?>> getLikedEpisodes();

  @override
  @GET('user/recent-episodes')
  Future<List<Episode?>> getRecentEpisodes();

  @override
  @GET('user/personalized')
  Future<List<Podcast?>> getPersonalizedPodcasts();

  @override
  @GET('user/subscribed')
  Future<List<Podcast?>> getSubscribedPodcasts();

  @override
  @POST('likes/like')
  Future<LikedEpisode> likeEpisode({
    @Body() required LikedEpisode episode,
  });

  @override
  @DELETE('likes/unlike')
  Future<void> unlikeEpisode({
    @Body() required LikedEpisode episode,
  });
}
