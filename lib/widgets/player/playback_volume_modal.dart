import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers.dart';
import '../../theme.dart';
import '../typography/heading.dart';

class PlaybackVolumeModal extends ConsumerWidget {
  const PlaybackVolumeModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(audioPlayerProvider);
    return Container(
      padding: const EdgeInsets.all(kPagePadding),
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(
            'Set volume',
            inPageContainer: false,
            headingType: HeadingType.h3,
          ),
          Row(
            children: [
              Icon(BootstrapIcons.volume_off),
              Expanded(
                child: Slider(
                  value: player.volume,
                  min: 0,
                  max: 1,
                  onChanged: (newVolume) => player.setVolume(newVolume),
                ),
              ),
              Icon(BootstrapIcons.volume_up),
            ],
          )
        ],
      ),
    );
  }
}
