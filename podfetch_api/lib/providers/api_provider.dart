import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/responses/search_response.dart';

abstract class PodfetchApiProvider {
  Future<List<Podcast>> getTrending({String? language, int? max});
  Future<Podcast> getPodcastById(int id);
  Future<SearchResponse> search(String query);
}
