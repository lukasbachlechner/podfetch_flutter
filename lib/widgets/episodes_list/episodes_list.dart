import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_api/responses/episodes_by_podcast_id_response.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/buttons/button.dart';
import 'package:podfetch_flutter/widgets/episodes_list/episodes_list_item.dart';
import 'package:visibility_detector/visibility_detector.dart';

class EpisodesList extends HookConsumerWidget {
  const EpisodesList({
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
    final scrollController = useScrollController();

    final episodesFetch = useMemoizedFuture<EpisodesByPodcastIdResponse>(
      () => ref
          .watch(apiProvider)
          .getEpisodesByPodcastId(podcastId, page: page.value, perPage: 20),
      keys: [page.value],
    );

    if (episodesFetch.snapshot.hasData &&
        episodesFetch.snapshot.connectionState == ConnectionState.done) {
      episodesToUse.value.addAll(episodesFetch.snapshot.data!.episodes!);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            separatorBuilder: (_, __) => const SizedBox(
              height: 16.0,
            ),
            itemBuilder: (context, index) {
              final episode = episodesToUse.value[index];
              return EpisodeListItem(episode: episode);
            },
            itemCount: episodesToUse.value.length,
          ),
          const SizedBox(
            height: 8.0,
          ),
          if (episodesFetch.snapshot.hasData &&
              episodesFetch.snapshot.data?.hasMore == true)
            VisibilityDetector(
                key: ValueKey(podcastId),
                onVisibilityChanged: (VisibilityInfo visibilityInfo) {
                  if (visibilityInfo.visibleFraction == 1.0) {
                    page.value++;
                  }
                },
                child: const Center(
                  child: CircularProgressIndicator(),
                ) /* PfButton(
                onPressed: () => page.value++,
                isLoading: episodesFetch.snapshot.connectionState !=
                    ConnectionState.done,
                child: const Text('Load more'),
              ), */
                ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
