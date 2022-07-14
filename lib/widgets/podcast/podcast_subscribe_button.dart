import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/models/subscribed_podcast.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';

import '../buttons/button.dart';
import '../notifications/notification_bar.dart';

class PodcastSubscribeButton extends HookConsumerWidget {
  const PodcastSubscribeButton({
    Key? key,
    required this.podcast,
  }) : super(key: key);

  final Podcast podcast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);

    if (!auth.isLoggedIn) {
      return const SizedBox.shrink();
    }

    final isSubscribed = auth.user!.subscribedPodcasts.where(
      (subscribedPodcast) {
        return subscribedPodcast?.podcastId == podcast.id.toString();
      },
    ).isNotEmpty;

    if (isSubscribed) {
      return PfButton(
        onPressed: () async {
          final confirmation = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('Unsubscribe from ${podcast.title}?'),
                actions: [
                  PfButton(
                    onPressed: () => context.router.pop(false),
                    child: const Text('Cancel'),
                  ),
                  PfButton(
                    buttonType: ButtonType.accent,
                    onPressed: () => context.router.pop(true),
                    child: const Text('Unsubscribe'),
                  )
                ],
              );
            },
          );
          final isConfirmed = confirmation ?? false;
          if (isConfirmed) {
            authNotifier.removeSubscription(podcast);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Subscribed'),
            SizedBox(width: 16.0),
            Icon(BootstrapIcons.bookmark_check_fill, size: 16.0),
          ],
        ),
      );
    }

    return PfButton(
      buttonType: ButtonType.accent,
      onPressed: () async {
        authNotifier.addSubscription(podcast);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Subscribe'),
          SizedBox(width: 16.0),
          Icon(BootstrapIcons.bookmark_fill, size: 16.0),
        ],
      ),
    );
  }
}
