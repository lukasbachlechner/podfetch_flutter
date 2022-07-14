import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/models/subscribed_podcast.dart';
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
  Future<SearchResponse> search(String query);

  Future<LoginResponse> login(Map<String, dynamic> json);
  Future<dynamic> logout({String? bearerToken});
  Future<User> getUser({String? bearerToken});

  Future<SubscribedPodcast> subscribeToPodcast({
    required SubscribedPodcast podcastToSubscribe,
  });

  Future<void> unsubscribeFromPodcast({
    required SubscribedPodcast podcastToUnsubscribe,
  });
}
