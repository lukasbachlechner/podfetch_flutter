import 'package:podfetch_api/models/model.dart';

class LikedEpisode implements Model {
  final int? id;
  final String episodeId;
  final int? userId;

  LikedEpisode(this.id, this.episodeId, this.userId);

  factory LikedEpisode.fromJson(Map<String, dynamic> json) => LikedEpisode(
        json['id'],
        json['episode_id'],
        json['user_id'],
      );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id ?? '',
      'episodeId': episodeId.toString(),
      'user_id': userId ?? '',
    };
  }
}
