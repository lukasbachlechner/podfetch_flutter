import 'package:podfetch_api/models/episode.dart';

class EpisodesByPodcastIdResponse {
  final List<Episode>? episodes;
  final bool? hasMore;

  const EpisodesByPodcastIdResponse(this.episodes, this.hasMore);

  factory EpisodesByPodcastIdResponse.fromJson(Map<String, dynamic> json) =>
      EpisodesByPodcastIdResponse(
        (json['episodes'] as List<dynamic>)
            .map((e) => Episode.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['hasMore'] as bool,
      );
}

/* class EmptySearchResponse extends EpisodesByPodcastIdResponse {
  const EmptySearchResponse() : super(null, null);
}
 */