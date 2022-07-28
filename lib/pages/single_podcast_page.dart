import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/services/language_service.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';
import 'package:podfetch_flutter/widgets/buttons/button.dart';
import 'package:podfetch_flutter/widgets/categories/category_chip.dart';
import 'package:podfetch_flutter/widgets/content_page/content_page.dart';
import 'package:podfetch_flutter/widgets/episodes_list/episodes_list.dart';
import 'package:podfetch_flutter/widgets/podcast/podcast_subscribe_button.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';
import 'package:podfetch_flutter/widgets/utils/html.dart';
import 'package:podfetch_flutter/widgets/utils/network.dart';
import 'package:podfetch_flutter/widgets/utils/page_container.dart';
import 'package:podfetch_flutter/widgets/utils/spacer.dart';

class SinglePodcastPage extends HookConsumerWidget {
  const SinglePodcastPage({
    Key? key,
    this.podcast,
    @PathParam('podcastId') required this.podcastId,
  }) : super(key: key);

  final Podcast? podcast;
  final int podcastId;

  List<Widget> _buildHeader(BuildContext context,
      List<StaticCategory?> staticCategories, Podcast podcastToUse) {
    return [
      const PfSpacer.top(),
      CachedNetworkImage(
        imageUrl: podcastToUse.safeImage,
        width: 200.0,
        height: 200.0,
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
      PodcastSubscribeButton(podcast: podcastToUse),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Podcast? podcastToUse = podcast;
    final tabController = useTabController(initialLength: 2);
    final selectedTabIndex = useState(0);

    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });

    final podcastFetch = useMemoizedFuture(() =>
        ref.watch(apiProvider).getPodcastById(podcastId, maxEpisodes: 10));

    final staticCategoriesRepository = ref.watch(categoriesProvider);

    if (podcastToUse != null || podcastFetch.snapshot.isReady) {
      podcastToUse ??= podcastFetch.snapshot.data;
      final staticCategories =
          staticCategoriesRepository.getAllByIds(podcastToUse!.categoryIds);

      return ContentPage(
        title: podcastToUse.title,
        header: _buildHeader(context, staticCategories, podcastToUse),
        onRefresh: () => podcastFetch.refresh(),
        headerImageUrl: podcastToUse.safeImage,
        body: [
          const SizedBox(
            height: 32.0,
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 0,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColorDark,
            flexibleSpace: PageContainer(
              child: TabBar(
                overlayColor: const MaterialStatePropertyAll(Colors.white12),
                indicatorColor: Theme.of(context).highlightColor,
                controller: tabController,
                tabs: const [
                  Tab(text: 'Episodes'),
                  Tab(text: 'Info'),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          SliverOffstage(
            offstage: selectedTabIndex.value != 0,
            sliver: podcastFetch.snapshot.isReady
                ? SliverEpisodesList(
                    episodes: podcastFetch.snapshot.data!.episodes,
                    podcastId: podcastId,
                  )
                : const SliverEpisodesSkeletonList(),
          ),
          SliverOffstage(
            offstage: selectedTabIndex.value != 1,
            sliver: podcastFetch.snapshot.isReady
                ? SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Heading(
                          'About',
                          headingType: HeadingType.h3,
                        ),
                        PageContainer(
                          bottom: 32,
                          child: PfHtml(
                            data: podcastToUse.description,
                          ),
                        ),
                        const Heading(
                          'Categories',
                          headingType: HeadingType.h3,
                        ),
                        PageContainer(
                          bottom: 32,
                          child: CategoryChipWrap(categories: staticCategories),
                        ),
                        const Heading(
                          'Author',
                          headingType: HeadingType.h3,
                        ),
                        PageContainer(
                          bottom: 32,
                          child: Text(podcastToUse.author),
                        ),
                        const Heading(
                          'Language',
                          headingType: HeadingType.h3,
                        ),
                        PageContainer(
                          bottom: 32,
                          child: Text(
                            LanguageService.getByIsoCode(
                              podcastToUse.language,
                            ).name,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
          const PfSpacer.bottom(),
        ],
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
  const CategoryChipWrap({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<StaticCategory?> categories;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.start,
      children: categories
          .map(
            (category) => CategoryChip(
              onTap: () => context.router.navigate(
                SingleCategoryRoute(
                  categoryId: category!.id,
                ),
              ),
              avatar: category?.iconData != null
                  ? Icon(
                      category?.iconData,
                      size: 16,
                    )
                  : null,
              category: category,
            ),
          )
          .toList(),
    );
  }
}
