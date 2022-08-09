import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/podcast.dart';
import '../../routes/router.gr.dart';
import '../media/image.dart';
import '../skeleton/skeleton_box.dart';

class SearchResultPodcastItem extends StatelessWidget {
  const SearchResultPodcastItem({Key? key, required this.podcast})
      : super(key: key);
  final Podcast podcast;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.navigateTo(
          SinglePodcastRoute(podcast: podcast, podcastId: podcast.id)),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Theme.of(context).primaryColor),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: PfImage(
                imageUrl: podcast.safeImage,
                width: 64.0,
                height: 64.0,
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    podcast.title.replaceAll('', '\u{200B}'),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    podcast.author,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            const Icon(
              BootstrapIcons.chevron_right,
              size: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultPodcastItemSkeleton extends StatelessWidget {
  const SearchResultPodcastItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Theme.of(context).primaryColor),
      child: Row(
        children: [
          const SkeletonBox(
            width: 64.0,
            height: 64.0,
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonBox(
                  width: 240.0,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                SkeletonBox(
                    width: 180.0,
                    textStyle: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
