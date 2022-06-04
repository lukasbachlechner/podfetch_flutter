// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podfetch_legacy_provider.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _PodfetchLegacyProvider implements PodfetchLegacyProvider {
  _PodfetchLegacyProvider(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.podfetch.app/v1/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Podcast>> getTrending({language = 'en', max = 10}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'lang': language, r'max': max};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Podcast>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'podcasts/trending',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Podcast.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Podcast> getPodcastById(id, {maxEpisodes}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'maxEpisodes': maxEpisodes};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Podcast>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'podcasts/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Podcast.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EpisodesByPodcastIdResponse> getEpisodesByPodcastId(id,
      {page = 10, perPage = 10}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EpisodesByPodcastIdResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'podcasts/${id}/episodes',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EpisodesByPodcastIdResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Episode> getEpisodeById(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Episode>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'episodes/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Episode.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchResponse> search(query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': query};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> login(json) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(json);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'auth/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
