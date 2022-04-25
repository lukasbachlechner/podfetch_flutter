library podfetch_api;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/models/podcast.dart';

// import 'package:flutter/foundation.dart';

void main() async {
  Response<String> response =
      await Dio().get('https://api.podfetch.app/v1/podcasts/743229');

  Map<String, dynamic> json = jsonDecode(response.data!);

  Podcast podcast = Podcast.fromJson(json);
  print(podcast.title);
  podcast.episodes.forEach(
    (episode) => print(episode.podcastTitle),
  );
}
