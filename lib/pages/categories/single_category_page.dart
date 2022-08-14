import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/widgets/podcasts_scroll_list/podcasts_scroll_list.dart';
import '../../hooks/use_memoized_future.dart';
import '../../providers.dart';
import '../../providers/api_provider.dart';
import '../../routes/router.gr.dart';
import '../../widgets/buttons/icon_button.dart';
import '../../widgets/podcasts_grid/podcasts_grid.dart';
import '../../widgets/typography/heading.dart';
import '../../widgets/utils/network.dart';
import '../../widgets/utils/spacer.dart';

import '../../widgets/base/page_wrap.dart';

class SingleCategoryPage extends HookConsumerWidget {
  const SingleCategoryPage({
    Key? key,
    @PathParam('categoryId') required this.categoryId,
  }) : super(key: key);

  final int categoryId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCategory = ref.watch(categoriesProvider).getById(categoryId);
    PodfetchApiProvider client = ref.watch(apiProvider);

    final podcastsFetch = useMemoizedFuture(
      () => Future.wait([
        client.getTrending(categories: categoryId.toString()),
        ...?currentCategory?.children?.map(
          (child) => client.getTrending(
            categories: child.id.toString(),
          ),
        ),
      ]),
    );

    if (currentCategory == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (currentCategory.children == null) {
      return PageWrap.refreshable(
        title: currentCategory.title,
        children: [
          const SizedBox(height: 16.0),
          Heading(
            currentCategory.title,
            headingType: HeadingType.h2,
          ),
          if (podcastsFetch.snapshot.isReady)
            SliverPodcastsGrid(
              podcasts: podcastsFetch.snapshot.data?[0],
            ),
        ],
      );
    }

    return PageWrap.refreshable(
      onRefresh: () async {
        podcastsFetch.refresh();
      },
      title: currentCategory.title,
      children: [
        const SizedBox(height: 16.0),
        Heading(
          'Popular in ${currentCategory.title}',
          headingType: HeadingType.h2,
        ),
        PodcastScrollList(
          isLoading: !podcastsFetch.snapshot.isReady,
          podcasts: podcastsFetch.snapshot.data?[0],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final category = currentCategory.children?[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Heading(
                        category?.title ?? '',
                        headingType: HeadingType.h2,
                        paddingBottom: 0.0,
                      ),
                      PfIconButton(
                        onPressed: () => context.router.push(
                            SingleCategoryRoute(categoryId: category!.id)),
                        icon: const Icon(BootstrapIcons.arrow_right),
                      )
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  PodcastScrollList(
                    isLoading: !podcastsFetch.snapshot.isReady,
                    podcasts: podcastsFetch.snapshot.data?[index + 1],
                  ),
                ],
              );
            },
            childCount: currentCategory.children?.length ?? 0,
          ),
        ),
      ],
    );
  }
}
