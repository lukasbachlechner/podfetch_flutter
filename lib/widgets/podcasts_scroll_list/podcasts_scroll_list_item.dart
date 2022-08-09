import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_api/models/podcast.dart';
import '../../routes/router.gr.dart';
import '../media/image.dart';
import '../skeleton/skeleton_box.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PodcastsScrollListItem extends HookWidget {
  const PodcastsScrollListItem({Key? key, required this.podcast})
      : super(key: key);
  final Podcast podcast;
  @override
  Widget build(BuildContext context) {
    const double boxSize = 144.0;
    final showImage = useState(false);

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
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: PfImage(imageUrl: podcast.safeImage),
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
