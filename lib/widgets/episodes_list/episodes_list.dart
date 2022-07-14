import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/responses/episodes_by_podcast_id_response.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/episodes_list/episodes_list_item.dart';
import 'package:podfetch_flutter/widgets/utils/network.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SliverEpisodesList extends HookConsumerWidget {
  const SliverEpisodesList({
    Key? key,
    required this.episodes,
    required this.podcastId,
  }) : super(key: key);

  final List<Episode> episodes;
  final int podcastId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = useState<int>(2);
    final episodesToUse = useState(episodes);
    final hasMore = useState(true);

    final episodesFetch = useMemoizedFuture<EpisodesByPodcastIdResponse>(
      () => ref
          .watch(apiProvider)
          .getEpisodesByPodcastId(podcastId, page: page.value, perPage: 20),
      keys: [page.value],
    );

    if (episodesFetch.snapshot.isReady) {
      episodesToUse.value.addAll(episodesFetch.snapshot.data!.episodes!);
      hasMore.value = episodesFetch.snapshot.data!.hasMore as bool;
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == episodesToUse.value.length) {
            return Visibility(
              visible: hasMore.value,
              child: VisibilityDetector(
                key: ValueKey(podcastId),
                onVisibilityChanged: (VisibilityInfo visibilityInfo) {
                  if (visibilityInfo.visibleFraction == 1.0) {
                    page.value++;
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPagePadding,
                    vertical: 4.0,
                  ),
                  child: EpisodesListItemSkeleton(),
                ),
              ),
            );
          }
          final episode = episodesToUse.value[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPagePadding,
              vertical: 4.0,
            ),
            child: EpisodeListItem(episode: episode),
          );
        },
        childCount: episodesToUse.value.length + 1,
      ),
    );
  }
}

class SliverEpisodesSkeletonList extends StatelessWidget {
  const SliverEpisodesSkeletonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kPagePadding,
            vertical: 4.0,
          ),
          child: EpisodesListItemSkeleton(),
        );
      }, childCount: 10),
    );
  }
}
