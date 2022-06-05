import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/service_locator.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';
import 'package:podfetch_flutter/widgets/categories/category_chip.dart';
import 'package:podfetch_flutter/widgets/content_page/content_page.dart';
import 'package:podfetch_flutter/widgets/episodes_list/episodes_list.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';
import 'package:podfetch_flutter/widgets/utils/spacer.dart';

class SinglePodcastPage extends HookConsumerWidget {
  const SinglePodcastPage(
      {Key? key, this.podcast, @PathParam('podcastId') required this.podcastId})
      : super(key: key);
  final Podcast? podcast;
  final int podcastId;

  List<Widget> _buildHeader(BuildContext context,
      List<StaticCategory?> staticCategories, Podcast podcastToUse) {
    return [
      PfSpacer.top(),
      Hero(
        tag: 'podcast-item-$podcastId',
        child: CachedNetworkImage(
          imageUrl: podcastToUse.safeImage,
          width: 200.0,
          height: 200.0,
        ),
      ),
      const SizedBox(
        height: 16.0,
      ),
      AutoSizeText(
        podcastToUse.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 4.0,
      ),
      Text(
        podcastToUse.author.toUpperCase(),
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(
        height: 16.0,
      ),
      CategoryChipWrap(
        categories: staticCategories,
      ),
    ];
  }

  List<Widget> _buildTitleBar(BuildContext context, Podcast podcast) {
    return [
      CachedNetworkImage(
        imageUrl: podcast.image,
        width: 32.0,
        height: 32.0,
      ),
      const SizedBox(
        width: 12.0,
      ),
      Expanded(
        child: Text(
          podcast.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Podcast? podcastToUse = podcast;

    final podcastFetch = useMemoizedFuture(() =>
        ref.watch(apiProvider).getPodcastById(podcastId, maxEpisodes: 10));

    final staticCategoriesRepository = ref.watch(categoriesProvider);

    if (podcastToUse != null ||
        (podcastFetch.snapshot.hasData &&
            podcastFetch.snapshot.connectionState == ConnectionState.done)) {
      podcastToUse ??= podcastFetch.snapshot.data;
      final staticCategories =
          staticCategoriesRepository.getAllByIds(podcastToUse!.categoryIds);

      return ContentPage(
        header: _buildHeader(context, staticCategories, podcastToUse),
        onRefresh: () => podcastFetch.refresh(),
        headerImageUrl: podcastToUse.safeImage,
        body: [
          const SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
            child: Html(data: podcastToUse.description),
          ),
          const SizedBox(
            height: 32.0,
          ),
          const Heading(
            'All Episodes',
            paddingBottom: 16.0,
            headingType: HeadingType.h3,
          ),
          (podcastFetch.snapshot.hasData &&
                  podcastFetch.snapshot.connectionState == ConnectionState.done)
              ? EpisodesList(
                  episodes: podcastFetch.snapshot.data!.episodes,
                  podcastId: podcastId,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
        titleBar: _buildTitleBar(context, podcastToUse),
        titleKey: Key('podcast-header-$podcastId'),
      );
    }

    return const PageWrap(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class CategoryChipWrap extends HookWidget {
  const CategoryChipWrap({Key? key, required this.categories, this.count = 2})
      : super(key: key);

  final List<StaticCategory?> categories;
  final int count;

  Widget _buildWrap(List<Widget> children) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final showAmount = useState(count);
    if (categories.length <= count) {
      return _buildWrap(
        categories
            .map(
              (category) => CategoryChip(
                category: category,
              ),
            )
            .toList(),
      );
    }
    return _buildWrap([
      ...categories
          .take(showAmount.value)
          .map(
            (category) => CategoryChip(
              category: category,
            ),
          )
          .toList(),
      (showAmount.value < categories.length)
          ? CategoryChip(
              avatar: const CircleAvatar(child: Icon(BootstrapIcons.plus)),
              content: Text('Show ${categories.length - count} more'),
              onTap: () => showAmount.value = categories.length,
            )
          : CategoryChip(
              avatar: const CircleAvatar(child: Icon(BootstrapIcons.dash)),
              content: const Text('Show less'),
              onTap: () => showAmount.value = count,
            ),
    ]);
  }
}
