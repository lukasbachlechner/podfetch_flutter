import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/podcast.dart';
import '../../routes/router.gr.dart';
import '../media/image.dart';
import '../skeleton/skeleton_box.dart';

class PodcastsGridItem extends StatelessWidget {
  const PodcastsGridItem({Key? key, required this.podcast}) : super(key: key);
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(
        SinglePodcastRoute(podcastId: podcast.id, podcast: podcast),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: PfImage(
              imageUrl: podcast.safeImage,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            podcast.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}

class PodcastsGridItemSkeleton extends StatelessWidget {
  const PodcastsGridItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AspectRatio(
          aspectRatio: 1,
          child: SkeletonBox(),
        ),
        const SizedBox(height: 4.0),
        SkeletonBox(
          text: 'Lorem ipsum',
          maxLines: 1,
          textStyle: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
