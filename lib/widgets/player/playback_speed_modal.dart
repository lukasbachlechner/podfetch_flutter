import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers.dart';
import '../../theme.dart';
import '../typography/heading.dart';

class PlaybackSpeedModal extends ConsumerWidget {
  const PlaybackSpeedModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const steps = [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
    final theme = Theme.of(context);

    final player = ref.watch(audioPlayerProvider);

    return Container(
      padding: const EdgeInsets.all(kPagePadding),
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Heading(
            'Set playback speed',
            inPageContainer: false,
            headingType: HeadingType.h3,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final step = steps[index];
                final isSelected = player.speed == step;
                return Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    selected: isSelected,
                    selectedColor: Colors.white,
                    selectedTileColor: theme.primaryColor,
                    onTap: () => player.setSpeed(step),
                    title: Text(
                      step.toString(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white.withOpacity(isSelected ? 1.0 : 0.5),
                      ),
                    ),
                    trailing:
                        (isSelected) ? const Icon(BootstrapIcons.check) : null,
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 2.0),
              itemCount: steps.length,
            ),
          ),
        ],
      ),
    );
    /* return Container(
      padding: const EdgeInsets.all(kPagePadding),
      color: Theme.of(context).backgroundColor,
      child: 
    ); */
  }
}
