import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/models/episode.dart';

class EpisodeProgressIndicator extends StatelessWidget {
  const EpisodeProgressIndicator({Key? key, required this.episode})
      : super(key: key);

  final Episode episode;
  @override
  Widget build(BuildContext context) {
    if (episode.playbackTimePercent > 0.99) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            BootstrapIcons.patch_check_fill,
            color: Theme.of(context).highlightColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          const Text(
            'Played',
          ),
        ],
      );
    }
    return Container(
      width: 64,
      padding: const EdgeInsets.only(left: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: LinearProgressIndicator(
          backgroundColor: Colors.white24,
          color: Theme.of(context).highlightColor,
          minHeight: 4.0,
          value: episode.playbackTimePercent,
        ),
      ),
    );
  }
}
