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

class EmptySearchResponse extends SearchResponse {
  const EmptySearchResponse() : super(null, null);
}
