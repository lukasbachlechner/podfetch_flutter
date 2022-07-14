import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/widgets/podcasts_grid/podcasts_grid.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';
import 'package:podfetch_flutter/widgets/utils/network.dart';
import 'package:podfetch_flutter/widgets/utils/spacer.dart';

import '../../widgets/base/page_wrap.dart';

class SingleCategoryPage extends HookConsumerWidget {
  const SingleCategoryPage(
      {Key? key, @PathParam('categoryId') required this.categoryId})
      : super(key: key);
  final int categoryId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCategory = ref.watch(categoriesProvider).getById(categoryId);
    PodfetchApiProvider client = ref.watch(apiProvider);

    final podcasts = useState<List<Podcast>>([]);

    final podcastsFetch = useMemoizedFuture(
      () => client.getTrending(max: 24, categories: categoryId.toString()),
    );

    if (podcastsFetch.snapshot.isReady) {
      podcasts.value.addAll(podcastsFetch.snapshot.data!);
    }

    return PageWrap.refreshable(
      title: currentCategory?.title,
      children: [
        const SizedBox(height: 16.0),
        Heading(
          'Popular in ${currentCategory?.title}',
          headingType: HeadingType.h2,
        ),
        SliverPodcastsGrid(podcasts: podcasts.value),
      ],
    );
  }
}
