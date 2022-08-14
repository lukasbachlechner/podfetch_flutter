import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_flutter/widgets/player/play_button.dart';
import 'package:podfetch_flutter/widgets/single_episode/episode_progress_indicator.dart';
import 'package:podfetch_flutter/widgets/skeleton/skeleton_box.dart';

import '../../routes/router.gr.dart';
import '../media/image.dart';
import '../player/like_button.dart';

class SingleEpisodeItem extends StatelessWidget {
  const SingleEpisodeItem({
    Key? key,
    this.episode,
  }) : super(key: key);

  final Episode? episode;

  @override
  Widget build(BuildContext context) {
    if (episode == null) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        context.navigateTo(
          SingleEpisodeRoute(episodeId: episode!.id, episode: episode),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.0),
                  child: PfImage(
                    imageUrl: episode!.image,
                    height: 36.0,
                    width: 36.0,
                    errorWidget: (context, url, error) => PfImage(
                      imageUrl: episode!.podcastImage ?? '',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        episode!.podcastTitle?.toUpperCase() ?? '',
                        maxLines: 1,
                        style:
                            const TextStyle(letterSpacing: 1.1, fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        episode!.title,
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      EpisodeProgressIndicator(episode: episode!),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                PlayButton(episode: episode!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SingleEpisodeItemSkeleton extends StatelessWidget {
  const SingleEpisodeItemSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SkeletonBox(
                borderRadius: 2.0,
                height: 36.0,
                width: 36.0,
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SkeletonBox(
                      text: 'Podcast Title',
                      textStyle: TextStyle(letterSpacing: 1.1, fontSize: 12.0),
                    ),
                    SkeletonBox(
                      text: 'Episode Title is a bit longer',
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    SkeletonBox(
                      width: 64.0,
                      height: 4.0,
                      borderRadius: 4.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              const SkeletonBox(
                width: 36.0,
                height: 36.0,
                shape: BoxShape.circle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
