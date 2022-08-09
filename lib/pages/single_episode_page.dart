import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/episode.dart';
import '../hooks/use_memoized_future.dart';
import '../providers.dart';
import '../providers/api_provider.dart';
import '../routes/router.gr.dart';
import '../theme.dart';
import '../widgets/base/page_wrap.dart';
import '../widgets/buttons/button.dart';
import '../widgets/buttons/icon_button.dart';
import '../widgets/content_page/content_page.dart';
import '../widgets/media/image.dart';
import '../widgets/player/download_button.dart';
import '../widgets/player/like_button.dart';
import '../widgets/player/play_button.dart';
import '../widgets/podcasts_scroll_list/podcasts_scroll_list_item.dart';
import '../widgets/settings/settings_tile.dart';
import '../widgets/typography/heading.dart';
import '../widgets/utils/html.dart';
import '../widgets/utils/page_container.dart';
import '../widgets/utils/spacer.dart';

class SingleEpisodePage extends HookConsumerWidget {
  const SingleEpisodePage({
    Key? key,
    @PathParam('episodeId') required this.episodeId,
    this.episode,
  }) : super(key: key);

  final int episodeId;
  final Episode? episode;

  List<Widget> _buildHeader(BuildContext context, Episode episodeToUse) {
    return [
      const PfSpacer.top(),
      Hero(
        tag: 'episode-item-$episodeId',
        child: PfImage(
          imageUrl: episodeToUse.image,
          width: 200.0,
          height: 200.0,
        ),
      ),
      const SizedBox(
        height: 16.0,
      ),
      Text(
        episodeToUse.title,
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
        episodeToUse.podcastTitle!.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(
        height: 32.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlayButton(
            episode: episodeToUse,
            size: 48.0,
            background: Theme.of(context).highlightColor,
          ),
          /* DownloadButton(
            episode: episodeToUse,
          ), */
          LikeButton(
            episode: episodeToUse,
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final episodeFetch = useMemoizedFuture(
        () => ref.watch(apiProvider).getEpisodeById(episodeId));
    if (episodeFetch.snapshot.hasData &&
        episodeFetch.snapshot.connectionState == ConnectionState.done) {
      final episodeToUse = episodeFetch.snapshot.data;
      return ContentPage(
        title: episodeToUse!.title,
        header: _buildHeader(context, episodeToUse),
        onRefresh: () => episodeFetch.refresh(),
        headerImageUrl: episodeToUse.image,
        body: [
          PageContainer(
            child: PfHtml(
              data: episodeToUse.description,
            ),
          ),
          const SizedBox(height: 24.0),
          const Heading(
            'Podcast',
            headingType: HeadingType.h3,
          ),
          PageContainer(
            child: GestureDetector(
              onTap: () {
                context.navigateTo(
                    SinglePodcastRoute(podcastId: episodeToUse.podcastId));
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: PfImage(
                        imageUrl:
                            episodeToUse.podcastImage ?? episodeToUse.image,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        episodeToUse.podcastTitle ?? 'To podcast',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const Icon(
                      BootstrapIcons.box_arrow_up_right,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const PfSpacer.bottom()
        ],
        titleBar: [Container()],
        titleKey: Key('episode-header-$episodeId'),
      );

      /* return PageWrap(
        title: episodeToUse!.title,
        showAppBar: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kToolbarHeight + kPagePadding,
                ),
                Center(
                  child: PfImage(
                    imageUrl: episodeToUse.image,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  episode!.title,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Html(
                  data: episodeToUse.description,
                  style: {
                    "body": Style(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      lineHeight: LineHeight.number(1.2),
                    ),
                    "a": Style(color: Colors.white)
                  },
                )
              ],
            ),
          ),
        ),
      ); */
    }

    return const PageWrap(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
