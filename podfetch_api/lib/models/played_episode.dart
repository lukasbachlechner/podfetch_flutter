import 'package:podfetch_api/models/model.dart';

class PlayedEpisode implements Model {
  final int id;
  final String episodeId;
  final int userId;
  final int playbackTime;

  PlayedEpisode(this.id, this.episodeId, this.userId, this.playbackTime);

  factory PlayedEpisode.fromJson(Map<String, dynamic> json) => PlayedEpisode(
        json['id'],
        json['episode_id'],
        json['user_id'],
        json['playback_time'],
      );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'episode_id': episodeId.toString(),
      'user_id': userId,
      'playback_time': playbackTime,
    };
  }
}
