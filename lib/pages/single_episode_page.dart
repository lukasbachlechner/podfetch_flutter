import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/episode.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';
import 'package:podfetch_flutter/widgets/content_page/content_page.dart';
import 'package:podfetch_flutter/widgets/utils/html.dart';
import 'package:podfetch_flutter/widgets/utils/page_container.dart';
import '../widgets/utils/spacer.dart';

class SingleEpisodePage extends HookConsumerWidget {
  const SingleEpisodePage(
      {Key? key, @PathParam('episodeId') required this.episodeId, this.episode})
      : super(key: key);

  final int episodeId;
  final Episode? episode;

  List<Widget> _buildHeader(BuildContext context, Episode episodeToUse) {
    return [
      const PfSpacer.top(),
      Hero(
        tag: 'episode-item-$episodeId',
        child: CachedNetworkImage(
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
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(
        height: 32.0,
      ),
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
                  child: CachedNetworkImage(
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
