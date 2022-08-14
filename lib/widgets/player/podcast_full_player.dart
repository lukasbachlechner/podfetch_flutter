import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/widgets/player/play_button.dart';
import 'package:podfetch_flutter/widgets/player/playback_speed_modal.dart';
import 'package:podfetch_flutter/widgets/player/playback_volume_modal.dart';
import 'package:we_slide/we_slide.dart';

import '../../providers.dart';
import '../../routes/router.gr.dart';
import '../../theme.dart';
import '../buttons/icon_button.dart';
import '../media/image.dart';

class PodcastFullPlayer extends ConsumerWidget {
  const PodcastFullPlayer({
    Key? key,
    required this.weSlideController,
  }) : super(key: key);

  final WeSlideController weSlideController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final theme = Theme.of(context);
    final episode = player.currentEpisode;
    final podcast = player.currentPodcast;

    if (episode == null) {
      return const SizedBox.shrink();
    }

    return Container(
      color: theme.primaryColorLight,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PfIconButton(
                    onPressed: () => weSlideController.hide(),
                    icon: const Icon(BootstrapIcons.chevron_down),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Now Playing',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  PfIconButton(
                    onPressed: () {},
                    icon: const Icon(BootstrapIcons.three_dots),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: PfImage(
                  imageUrl: episode.image,
                ),
              ),
              const SizedBox(height: 48.0),
              GestureDetector(
                onTap: () {
                  weSlideController.hide();
                  context.router.push(SingleEpisodeRoute(
                    episodeId: episode.id,
                    episode: episode,
                  ));
                },
                child: Text(
                  episode.title,
                  style: theme.textTheme.displaySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4.0),
              GestureDetector(
                onTap: () {
                  weSlideController.hide();
                  context.router.push(SinglePodcastRoute(
                    podcastId: podcast!.id,
                    podcast: podcast,
                  ));
                },
                child: Text(
                  podcast?.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16.0),
              if (player.progress != null &&
                  player.totalDuration != null &&
                  player.buffered != null)
                ProgressBar(
                  baseBarColor: theme.highlightColor.withOpacity(0.4),
                  onSeek: (Duration newDuration) => player.seek(newDuration),
                  progressBarColor: theme.highlightColor,
                  bufferedBarColor: theme.highlightColor.withOpacity(0.4),
                  thumbColor: theme.highlightColor,
                  progress: player.progress!,
                  total: player.totalDuration!,
                  buffered: player.buffered,
                  timeLabelType: TimeLabelType.remainingTime,
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 32,
                    onPressed: () => player.seekTo(-30),
                    icon: const Icon(
                      Icons.replay_30_rounded,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: PlayButton(
                      episode: episode,
                      size: 64,
                    ),
                  ),
                  IconButton(
                    iconSize: 32,
                    onPressed: () => player.seekTo(30),
                    icon: const Icon(
                      Icons.forward_30_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 32,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const PlaybackVolumeModal();
                        },
                      );
                    },
                    icon: const Icon(BootstrapIcons.volume_up),
                  ),
                  const SizedBox(width: 16.0),
                  IconButton(
                    iconSize: 32,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const PlaybackSpeedModal();
                        },
                      );
                    },
                    icon: const Icon(Icons.speed),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
