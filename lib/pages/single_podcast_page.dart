import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/service_locator.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';
import 'to_implement.dart';

class SinglePodcastPage extends StatelessWidget {
  const SinglePodcastPage(
      {Key? key, this.podcast, @PathParam('podcastId') this.podcastId})
      : super(key: key);
  final Podcast? podcast;
  final int? podcastId;

  Future<Podcast>? _fetchPodcast() {
    if (podcast != null) {
      return Future.value(podcast);
    }
    if (podcastId != null) {
      return getIt<PodfetchApiProvider>().getPodcastById(podcastId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      child: Column(
        children: [
          if (podcast != null)
            Hero(
              tag: 'podcast-item-${podcast!.id}',
              child: CachedNetworkImage(
                imageUrl: podcast!.safeImage,
                width: 240,
                height: 240,
              ),
            ),
          FutureBuilder(
              future: _fetchPodcast(),
              builder: (context, AsyncSnapshot<Podcast> snapshot) {
                if (snapshot.hasData) {
                  final _podcast = snapshot.data!;
                  return Column(
                    children: [
                      Text(_podcast.title),
                      Text(_podcast.description),
                      Text(_podcast.author),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              }),
        ],
      ),
    );
  }
}
