import 'package:intl/intl.dart';
import 'package:podfetch_api/models/model.dart';

/// @TODO: get the podcastTitle if it's not present in the json
class Episode implements Model {
  final int id;
  final String title;
  final String titleSlug;
  final String description;
  final String excerpt;
  final String image;
  final String language;
  final int podcastId;
  final bool explicit;
  final String audioUrl;
  final String audioType;
  final int audioSize;
  final String audioPrettySize;
  final int audioDuration;
  final int datePublished;

  final int? playbackTime;
  final String? podcastTitle;

  Episode(
      {required this.id,
      required this.title,
      required this.titleSlug,
      required this.description,
      required this.excerpt,
      required this.image,
      required this.language,
      required this.podcastId,
      required this.explicit,
      required this.audioUrl,
      required this.audioType,
      required this.audioSize,
      required this.audioPrettySize,
      required this.audioDuration,
      required this.datePublished,
      this.playbackTime,
      this.podcastTitle});

  factory Episode.fromJson(Map<String, dynamic> json, {String? podcastTitle}) =>
      Episode(
        id: json['id'] as int,
        title: json['title'] as String,
        titleSlug: json['titleSlug'] as String,
        description: json['description'] as String,
        excerpt: json['excerpt'] as String,
        image: json['image'] as String,
        language: json['language'] as String,
        podcastId: json['podcastId'] as int,
        explicit: json['explicit'] as bool,
        audioUrl: json['audioUrl'] as String,
        audioType: json['audioType'] as String,
        audioSize: json['audioSize'] as int,
        audioPrettySize: json['audioPrettySize'] as String,
        audioDuration: json['audioDuration'] as int,
        datePublished: json['datePublished'] as int,
        playbackTime: json['playbackTime'] as int?,
        podcastTitle: json['podcastTitle'] as String? ?? podcastTitle,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'titleSlug': titleSlug,
        'description': description,
        'excerpt': excerpt,
        'image': image,
        'language': language,
        'podcastId': podcastId,
        'explicit': explicit,
        'audioUrl': audioUrl,
        'audioType': audioType,
        'audioSize': audioSize,
        'audioPrettySize': audioPrettySize,
        'audioDuration': audioDuration,
        'datePublished': datePublished,
        'playbackTime': playbackTime,
        'podcastTitle': podcastTitle,
      };

  String get datePublishedFormatted {
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(
      datePublished * 1000000,
    );

    return DateFormat.MMMd().format(date);
  }

  String get audioDurationFormatted {
    Duration duration = Duration(seconds: audioDuration);

    return duration.inMinutes.toString() + ' min';
  }
}
