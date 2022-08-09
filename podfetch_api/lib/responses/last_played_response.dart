import 'package:podfetch_api/models/category.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/podcast.dart';

class LastPlayedResponse {
  final Episode? episode;

  bool get hasEpisode => episode != null;

  const LastPlayedResponse({this.episode});

  factory LastPlayedResponse.fromJson(responseContent) {
    if (responseContent.isEmpty) {
      return const LastPlayedResponse();
    }

    final Map<String, dynamic> json = responseContent;
    Episode episode = Episode.fromJson(json['episode']);
    episode.playbackTime = json['playbackTime'];
    return LastPlayedResponse(episode: episode);
  }
}
