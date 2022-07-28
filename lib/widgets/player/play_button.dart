import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/episode.dart';

import '../../providers/player_provider.dart';

class PlayButton extends HookConsumerWidget {
  const PlayButton({
    Key? key,
    required this.episode,
    this.size = 36.0,
    this.background = Colors.white12,
  }) : super(key: key);

  final Episode episode;
  final double size;
  final Color background;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    final isPlaying = player.isPlaying && player.currentEpisode == episode;

    return GestureDetector(
      onTap: () {
        if (player.currentEpisode == null || player.currentEpisode != episode) {
          player.playEpisode(episode);
        } else if (player.isPlaying) {
          player.pauseAudio();
        } else {
          player.playAudio();
        }
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: isPlaying
              ? const Icon(BootstrapIcons.pause)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 2.0,
                    ),
                    Icon(
                      BootstrapIcons.play_fill,
                      size: size / 3 * 2,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
