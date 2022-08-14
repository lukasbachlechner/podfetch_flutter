import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/widgets/player/play_button.dart';
import 'package:we_slide/we_slide.dart';

import '../../providers.dart';
import '../../theme.dart';
import '../media/image.dart';

class PodcastMiniPlayer extends ConsumerWidget {
  const PodcastMiniPlayer({
    Key? key,
    required this.height,
    required this.weSlideController,
  }) : super(key: key);

  final double height;
  final WeSlideController weSlideController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final theme = Theme.of(context);
    final episode = player.currentEpisode;

    if (episode == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => weSlideController.show(),
      child: Container(
        color: theme.primaryColorLight,
        child: Stack(
          children: [
            LinearProgressIndicator(
              minHeight: 2,
              color: theme.highlightColor,
              backgroundColor: Colors.white24,
              value: player.completion,
            ),
            /* FractionallySizedBox(
              widthFactor: player.completion,
              heightFactor: 1.0,
              child: Stack(
                children: [
                  Container(color: theme.highlightColor.withOpacity(0.4)),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      color: theme.highlightColor.withOpacity(0.5),
                      width: 2.0,
                    ),
                  )
                ],
              ),
            ), */
            SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Stack(
                        children: [
                          PfImage(
                            width: 36.0,
                            height: 36.0,
                            imageUrl: episode.image,
                          ),
                          Visibility(
                            visible: player.isLoading,
                            child: Positioned.fill(
                              child: Container(
                                color: theme.backgroundColor.withOpacity(0.8),
                                child: const Center(
                                  child: SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*  SizedBox(
                            height: 20,
                            child: Marquee(
                              text: episode.title,
                              velocity: 10,
                            ),
                          ), */
                          Text(
                            episode.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            player.currentPodcast?.title ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    PlayButton(episode: episode),
                  ],
                ),
              ),
            ),

            // Text(player.progress?.inMilliseconds.toString() ?? ''),
          ],
        ),
      ),
    );
  }
}
