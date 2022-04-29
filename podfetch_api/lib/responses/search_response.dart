import 'package:podfetch_api/models/category.dart';
import 'package:podfetch_api/models/podcast.dart';

class SearchResponse {
  final List<Podcast>? podcasts;
  final List<Category>? categories;

  const SearchResponse(this.podcasts, this.categories);

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        (json['podcasts'] as List<dynamic>)
            .map((e) => Podcast.fromJson(e as Map<String, dynamic>))
            .toList(),
        (json['categories'] as List<dynamic>)
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

/**
 * Category(this.id, this.name, this.slug);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        json['id'] as int,
        json['name'] as String,
        json['slug'] as String,
      );

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'slug': slug,
      };
 */