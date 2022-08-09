import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/liked_episode.dart';
import 'package:podfetch_api/models/model.dart';
import 'package:podfetch_api/models/played_episode.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/models/subscribed_podcast.dart';
import 'package:podfetch_api/podfetch_api.dart';

class User implements Model {
  final int id;
  final String email;
  final List<StaticCategory?> categoryPreferences;
  final List<PlayedEpisode?> playedEpisodes;
  final List<LikedEpisode?> likedEpisodes;
  final List<SubscribedPodcast?> subscribedPodcasts;
  final DateTime createdAt;

  User(
    this.id,
    this.email,
    this.categoryPreferences,
    this.playedEpisodes,
    this.likedEpisodes,
    this.subscribedPodcasts,
    this.createdAt,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['id'] as int,
        json['email'] as String,
        PodfetchStaticCategoriesRepository()
            .getAllByIds(List.from(json['category_preferences'])),
        ((json['playedEpisodes'] ?? []) as List<dynamic>)
            .map((e) => PlayedEpisode.fromJson(e))
            .toList(),
        ((json['likedEpisodes'] ?? []) as List<dynamic>)
            .map((e) => LikedEpisode.fromJson(e))
            .toList(),
        ((json['subscribedPodcasts'] ?? []) as List<dynamic>)
            .map((e) => SubscribedPodcast.fromJson(e))
            .toList(),
        DateTime.parse(json['created_at']),
      );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'category_preferences':
          categoryPreferences.map((category) => category?.id),
    };
  }
}
