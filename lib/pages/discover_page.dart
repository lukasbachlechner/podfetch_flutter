import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/language_provider.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/auth/auth_callout.dart';
import 'package:podfetch_flutter/widgets/buttons/icon_button.dart';

import 'package:podfetch_flutter/widgets/podcast_carousel/podcast_carousel.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';
import 'package:podfetch_flutter/widgets/utils/spacer.dart';

import '../widgets/base/page_wrap.dart';
import '../widgets/podcasts_scroll_list/podcasts_scroll_list.dart';

class DiscoverPage extends HookConsumerWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PodfetchApiProvider client = ref.watch(apiProvider);
    final discoverRequestKey = useState<UniqueKey>(UniqueKey());

    final allCategories = ref.watch(categoriesProvider).getAll();

    final generalFetch = useMemoizedFuture(
      () => Future.wait(
        [
          client.getTrending(max: 5),
          client.getTrending(max: 15),
        ],
      ),
    );

    final categoriesFetch = useMemoizedFuture(
      () => Future.wait(
        allCategories
            .map((category) =>
                client.getTrending(categories: category.id.toString()))
            .toList(),
      ),
    );

    final generalSnapshot = generalFetch.snapshot;
    final categoriesSnapshot = categoriesFetch.snapshot;

    ref.listen(
      languageProvider,
      (previous, next) => discoverRequestKey.value = UniqueKey(),
    );

    return PageWrap.refreshable(
      onRefresh: () async {
        generalFetch.refresh();
        categoriesFetch.refresh();
      },
      children: [
        const Heading('Discover'),
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
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: kPagePadding, vertical: 16.0),
          child: AuthCallout(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final category = allCategories[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Heading(
                      category.title,
                      headingType: HeadingType.h2,
                      paddingBottom: 0.0,
                    ),
                    PfIconButton(
                      onPressed: () => context.router
                          .push(SingleCategoryRoute(categoryId: category.id)),
                      icon: const Icon(BootstrapIcons.arrow_right),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                PodcastScrollList(
                  isLoading: !(categoriesSnapshot.hasData &&
                      categoriesSnapshot.connectionState ==
                          ConnectionState.done),
                  podcasts: categoriesSnapshot.data?[index],
                ),
              ],
            );
          }, childCount: allCategories.length),
        ),
      ],
    );
  }
}
