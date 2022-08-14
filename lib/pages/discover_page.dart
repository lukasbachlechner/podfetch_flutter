import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/providers/api_provider.dart';
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

import '../widgets/categories/categories_grid.dart';
import '../widgets/podcast_carousel/podcast_carousel.dart';
import '../widgets/typography/heading.dart';
import '../widgets/utils/spacer.dart';

import '../widgets/base/page_wrap.dart';
import '../widgets/podcasts_scroll_list/podcasts_scroll_list.dart';

class DiscoverPage extends HookConsumerWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PodfetchApiProvider client = ref.watch(apiProvider);
    final language = ref.watch(languageProvider);

    final allCategories = ref.watch(categoriesProvider).getAll();

    final generalFetch = useMemoizedFuture(
      () => Future.wait(
        [
          client.getTrending(max: 5),
          client.getTrending(max: 15),
        ],
      ),
      keys: [language.isoCode],
    );

    final categoriesFetch = useMemoizedFuture(
      () => Future.wait(
        allCategories
            .map((category) =>
                client.getTrending(categories: category.id.toString()))
            .toList(),
      ),
      keys: [language.isoCode],
    );

    final generalSnapshot = generalFetch.snapshot;
    final categoriesSnapshot = categoriesFetch.snapshot;

    return PageWrap.refreshable(
      onRefresh: () async {
        generalFetch.refresh();
        categoriesFetch.refresh();
      },
      children: [
        PageContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Heading(
                'Discover',
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
        const Heading(
          'Featured',
          headingType: HeadingType.h2,
        ),
        PodcastCarousel(
          isLoading: !(generalSnapshot.hasData &&
              generalSnapshot.connectionState == ConnectionState.done),
          podcasts: generalSnapshot.data?[0],
        ),
        const SizedBox(height: 16.0),
        const Heading(
          'Trending',
          headingType: HeadingType.h2,
        ),
        PodcastScrollList(
          isLoading: !(generalSnapshot.hasData &&
              generalSnapshot.connectionState == ConnectionState.done),
          podcasts: generalSnapshot.data?[1].sublist(5),
        ),
        const Heading(
          'Categories',
          headingType: HeadingType.h2,
        ),
        const CategoriesGrid(
          columnCount: 2,
          aspectRatio: 2 / 1,
        ),
        const PfSpacer.bottom(),
      ],
    );
  }
}
