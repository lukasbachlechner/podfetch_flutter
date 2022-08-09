import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/episode.dart';
import '../../providers.dart';
import '../../providers/auth_provider.dart';
import '../buttons/icon_button.dart';

class LikeButton extends ConsumerWidget {
  const LikeButton({
    Key? key,
    required this.episode,
    this.size = 24.0,
  }) : super(key: key);

  final Episode episode;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedState = ref.watch(likedEpisodesProvider);
    bool isEpisodeLiked = likedState.isEpisodeLiked(episode);
    return PfIconButton(
      onPressed: () async {
        final likedProvider = ref.read(likedEpisodesProvider.notifier);
        if (!isEpisodeLiked) {
          await likedProvider.likeEpisode(episode);
        } else {
          await likedProvider.unlikeEpisode(episode);
        }
      },
      icon: Icon(
        isEpisodeLiked ? BootstrapIcons.heart_fill : BootstrapIcons.heart,
        size: size,
      ),
    );
  }
}
