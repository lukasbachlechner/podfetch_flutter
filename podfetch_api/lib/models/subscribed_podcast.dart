import 'package:podfetch_api/models/model.dart';

class SubscribedPodcast implements Model {
  final int? id;
  final String podcastId;

  SubscribedPodcast(this.id, this.podcastId);

  factory SubscribedPodcast.fromJson(Map<String, dynamic> json) =>
      SubscribedPodcast(
        json['id'] as int,
        json['podcast_id'] as String,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id ?? '',
        'podcastId': podcastId,
      };
}
