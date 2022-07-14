import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/skeleton/skeleton_box.dart';

class PodcastCarouselItem extends StatelessWidget {
  const PodcastCarouselItem({Key? key, required this.podcast})
      : super(key: key);
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router
          .push(SinglePodcastRoute(podcastId: podcast.id, podcast: podcast)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: kPagePadding),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  podcast.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: 'by ',
                      children: [
                        TextSpan(
                          text: podcast.author,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            )),
            const SizedBox(
              width: 8.0,
            ),
            Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.0),
                  child: CachedNetworkImage(
                    imageUrl: podcast.safeImage,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PodcastCarouselItemSkeleton extends StatelessWidget {
  const PodcastCarouselItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: kPagePadding),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonBox.light(
                text: 'Lorem ipsum dolor sit amet',
                textStyle: Theme.of(context).textTheme.displaySmall,
              ),
              SkeletonBox.light(
                text: 'by Lorem ipsum',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          )),
          const SizedBox(
            width: 8.0,
          ),
          const Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: SkeletonBox.light(
                borderRadius: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
