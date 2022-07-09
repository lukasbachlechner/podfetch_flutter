import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_flutter/pages/single_podcast_page.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/theme.dart';

class PodcastCarouselItem extends StatelessWidget {
  const PodcastCarouselItem({Key? key, required this.podcast})
      : super(key: key);
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.router.push(SinglePodcastRoute(podcastId: podcast.id)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(horizontal: kPagePadding),
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
