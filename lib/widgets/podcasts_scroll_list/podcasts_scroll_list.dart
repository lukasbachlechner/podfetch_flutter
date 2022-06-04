import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/podcasts_scroll_list/podcasts_scroll_list_item.dart';

class PodcastScrollList extends HookWidget {
  const PodcastScrollList({Key? key, required this.request, this.requestKey})
      : super(key: key);

  final Future<List<Podcast>> request;
  final UniqueKey? requestKey;

  @override
  Widget build(BuildContext context) {
    final fetch =
        useMemoizedFuture<List<Podcast>>(() => request, keys: [requestKey]);
    final snapshot = fetch.snapshot;
    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: kPagePadding,
            ),
            ...snapshot.data!
                .map((podcast) => PodcastsScrollListItem(podcast: podcast))
                .toList(),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: kPagePadding,
          ),
          ...List.filled(5, 0)
              .map((podcast) => const PodcastsScrollListItemSkeleton())
              .toList(),
        ],
      ),
    );
  }
}
