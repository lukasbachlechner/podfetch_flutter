import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/widgets/utils/spacer.dart';
import '../hooks/use_memoized_future.dart';
import '../providers.dart';
import '../providers/api_provider.dart';
import '../theme.dart';
import '../widgets/auth/auth_callout.dart';
import '../widgets/episodes_list/episodes_list.dart';
import '../widgets/episodes_list/episodes_list_item.dart';
import '../widgets/page/page_header.dart';
import '../widgets/typography/heading.dart';
import '../widgets/utils/network.dart';
import '../widgets/utils/page_container.dart';
import '../providers/auth_provider.dart';
import '../widgets/base/page_wrap.dart';

class ListsPage extends ConsumerWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return const PageWrap(
      useSlivers: true,
      children: [
        Heading(
          'Liked',
        ),
        SliverLikedEpisodesList(),
      ],
    );
  }
}

class SliverLikedEpisodesList extends HookConsumerWidget {
  const SliverLikedEpisodesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedState = ref.watch(likedEpisodesProvider);
    final likedEpisodesFetch = useMemoizedFuture(
      () => ref.watch(apiProvider).getLikedEpisodes(),
      keys: [likedState],
    );
    if (likedEpisodesFetch.snapshot.isReady) {
      if (likedEpisodesFetch.snapshot.data!.isNotEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final episode = likedEpisodesFetch.snapshot.data?[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kPagePadding,
                    vertical: 4.0,
                  ),
                  child: EpisodeListItem(
                    episode: episode!,
                    showPodcastTitle: true,
                  ));
            },
            childCount: likedEpisodesFetch.snapshot.data!.length,
          ),
        );
      }
      return SliverFillRemaining(
        hasScrollBody: false,
        child: PageContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                BootstrapIcons.heart,
                size: 72,
                color: Colors.white24,
              ),
              SizedBox(height: 16.0),
              Text(
                "You didn't like any episodes so far. Tap the heart icon at any episode and it will appear here.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kPagePadding,
              vertical: 4.0,
            ),
            child: EpisodesListItemSkeleton(),
          );
        },
        childCount: 4,
      ),
    );
  }
}
