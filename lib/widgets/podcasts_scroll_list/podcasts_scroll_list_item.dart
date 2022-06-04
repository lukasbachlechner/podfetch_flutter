import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/widgets/skeleton/skeleton_box.dart';

class PodcastsScrollListItem extends StatelessWidget {
  const PodcastsScrollListItem({Key? key, required this.podcast})
      : super(key: key);
  final Podcast podcast;
  @override
  Widget build(BuildContext context) {
    const double boxSize = 144.0;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        width: boxSize,
        child: GestureDetector(
          onTap: () {
            context.navigateTo(
              SinglePodcastRoute(podcast: podcast, podcastId: podcast.id),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: 'podcast-item-${podcast.id}',
                child: Visibility(
                  visible: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: CachedNetworkImage(
                          imageUrl: podcast.safeImage,
                          fit: BoxFit.cover,
                          errorWidget: (context, String error, __) {
                            return const Center(
                              child: Icon(Icons.warning),
                            );
                          },
                          placeholder: (_, __) {
                            return Container(
                              color: Theme.of(context).primaryColor,
                              width: boxSize,
                              height: boxSize,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                podcast.title.replaceAll('', '\u{200B}'),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  height: 1.0,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PodcastsScrollListItemSkeleton extends StatelessWidget {
  const PodcastsScrollListItemSkeleton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const double boxSize = 144.0;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        width: boxSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SkeletonBox(height: boxSize),
            SizedBox(
              height: 8.0,
            ),
            SkeletonBox(
              width: 120.0,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
