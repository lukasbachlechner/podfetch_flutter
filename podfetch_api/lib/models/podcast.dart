import 'package:json_annotation/json_annotation.dart';
import 'package:podfetch_api/models/category.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/model.dart';

class Podcast implements Model {
  final int id;
  final String url;
  final String title;
  final String titleSlug;
  final String description;
  final String author;
  final String image;
  final String language;
  final List<Episode> episodes;
  final List<Category> categories;

  Podcast(this.id, this.url, this.title, this.titleSlug, this.description,
      this.author, this.image, this.language, this.episodes, this.categories);

  factory Podcast.fromJson(Map<String, dynamic> json) => Podcast(
        json['id'] as int,
        json['url'] as String,
        json['title'] as String,
        json['titleSlug'] as String,
        json['description'] as String,
        json['author'] as String,
        json['image'] as String,
        json['language'] as String,
        (json['episodes'] as List<dynamic>)
            .map((e) => Episode.fromJson(e as Map<String, dynamic>,
                podcastTitle: json['title']))
            .toList(),
        (json['categories'] as List<dynamic>)
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
      'titleSlug': titleSlug,
      'description': description,
      'author': author,
      'image': image,
      'language': language,
      'episodes': episodes.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }
}
