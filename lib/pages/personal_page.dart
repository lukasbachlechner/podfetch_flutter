import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/widgets/episodes_list/episodes_list_item.dart';
import 'package:podfetch_flutter/widgets/utils/network.dart';
import 'package:podfetch_flutter/widgets/utils/page_container.dart';
import '../hooks/use_memoized_future.dart';
import '../providers.dart';
import '../providers/api_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../routes/router.gr.dart';
import '../search/search_delegate.dart';
import '../theme.dart';
import '../widgets/auth/auth_callout.dart';
import '../widgets/auth/auth_guard.dart';
import '../widgets/base/app_bar.dart';
import '../widgets/buttons/icon_button.dart';

import '../widgets/podcast_carousel/podcast_carousel.dart';
import '../widgets/single_episode/single_episode_item.dart';
import '../widgets/typography/heading.dart';
import '../widgets/utils/spacer.dart';

import '../widgets/base/page_wrap.dart';
import '../widgets/podcasts_scroll_list/podcasts_scroll_list.dart';

class PersonalPage extends HookConsumerWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PodfetchApiProvider client = ref.watch(apiProvider);
    final language = ref.watch(languageProvider);

    final allCategories = ref.watch(categoriesProvider).getAll();

    final podcastsFetch = useMemoizedFuture(
      () => Future.wait(
        [
          client.getSubscribedPodcasts(),
          client.getPersonalizedPodcasts(),
        ],
      ),
      keys: [language.isoCode],
    );

    final lastPlayedEpisodeFetch = useMemoizedFuture(
      () => client.getLastPlayedEpisode(),
    );

    final recentEpisodesFetch = useMemoizedFuture(
      () => client.getRecentEpisodes(),
    );

    return PageWrap.refreshable(
      onRefresh: () async {
        podcastsFetch.refresh();
        lastPlayedEpisodeFetch.refresh();
        recentEpisodesFetch.refresh();
      },
      children: [
        PageContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Heading(
                'For You',
                inPageContainer: false,
              ),
              PfAppBarCircleButton(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: PodfetchSearchDelegate(ref),
                    useRootNavigator: true,
                  );
                },
                icon: const Icon(BootstrapIcons.search),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        if (lastPlayedEpisodeFetch.snapshot.isReady &&
            lastPlayedEpisodeFetch.snapshot.data!.hasEpisode) ...[
          const Heading(
            'Continue listening',
            headingType: HeadingType.h2,
          ),
          PageContainer(
            child: lastPlayedEpisodeFetch.snapshot.isReady &&
                    lastPlayedEpisodeFetch.snapshot.data!.hasEpisode
                ? EpisodeListItem(
                    episode: lastPlayedEpisodeFetch.snapshot.data!.episode!)
                : const EpisodesListItemSkeleton(),
          ),
          const SizedBox(height: 16.0),
        ],
        if (recentEpisodesFetch.snapshot.isReady &&
            recentEpisodesFetch.snapshot.data!.isNotEmpty) ...[
          const Heading(
            'Recent Episodes',
            headingType: HeadingType.h2,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
            sliver: recentEpisodesFetch.snapshot.isReady
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final episode =
                            recentEpisodesFetch.snapshot.data?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SingleEpisodeItem(episode: episode),
                        );
                      },
                      childCount: recentEpisodesFetch.snapshot.data?.length,
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: SingleEpisodeItemSkeleton(),
                        );
                      },
                      childCount: 4,
                    ),
                  ),
          ),
          const SizedBox(height: 16.0),
        ],
        if (podcastsFetch.snapshot.isReady &&
            podcastsFetch.snapshot.data![0].isNotEmpty) ...[
          const Heading(
            'Subscribed',
            headingType: HeadingType.h2,
          ),
          PodcastScrollList(
            isLoading: !(podcastsFetch.snapshot.isReady),
            podcasts: podcastsFetch.snapshot.data?[0],
          ),
          const SizedBox(height: 16.0),
        ],
        const Heading(
          'Podcasts you might like',
          headingType: HeadingType.h2,
        ),
        PodcastScrollList(
          isLoading: !(podcastsFetch.snapshot.isReady),
          podcasts: podcastsFetch.snapshot.data?[1],
        ),
        const PfSpacer.bottom(),
      ],
    );
  }
}
