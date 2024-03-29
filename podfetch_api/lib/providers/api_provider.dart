import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/liked_episode.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/models/subscribed_podcast.dart';
import 'package:podfetch_api/requests/signup_request.dart';
import 'package:podfetch_api/responses/check_email_response.dart';
import 'package:podfetch_api/responses/last_played_response.dart';
import 'package:podfetch_api/responses/login_response.dart';
import 'package:podfetch_api/responses/search_response.dart';

import '../models/user.dart';
import '../responses/episodes_by_podcast_id_response.dart';

abstract class PodfetchApiProvider {
  Future<List<Podcast>> getTrending(
      {String? language, int? max, String? categories});
  Future<Podcast> getPodcastById(int id, {int? maxEpisodes});
  Future<EpisodesByPodcastIdResponse> getEpisodesByPodcastId(int id,
      {int? page = 1, int? perPage = 10});
  Future<Episode> getEpisodeById(int id);

  Future<LastPlayedResponse> getLastPlayedEpisode();
  Future<List<Episode?>> getLikedEpisodes();
  Future<List<Episode?>> getRecentEpisodes();
  Future<List<Podcast?>> getPersonalizedPodcasts();
  Future<List<Podcast?>> getSubscribedPodcasts();

  Future<SearchResponse> search(String query);

  Future<LoginResponse> login(Map<String, dynamic> json);
  Future<dynamic> logout({String? bearerToken});
  Future<User> getUser({String? bearerToken});
  Future<CheckEmailResponse> checkEmail(String email);
  Future<User> signUp(SignupRequest signupRequest);

  Future<SubscribedPodcast> subscribeToPodcast({
    required SubscribedPodcast podcastToSubscribe,
  });

  Future<void> unsubscribeFromPodcast({
    required SubscribedPodcast podcastToUnsubscribe,
  });

  Future<LikedEpisode> likeEpisode({required LikedEpisode episode});
  Future<void> unlikeEpisode({required LikedEpisode episode});
}
