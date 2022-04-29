import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/pages/login_page.dart';
import 'package:podfetch_flutter/service_locator.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';

import '../routes/router.gr.dart';
import '../widgets/base/page_wrap.dart';
import '../widgets/podcasts_scroll_list/podcasts_scroll_list.dart';

class DiscoverPage extends HookWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  _pageRequests() async {
    List<Podcast> trendingPodcasts =
        await getIt<PodfetchApiProvider>().getTrending();
    return trendingPodcasts;
  }

  @override
  Widget build(BuildContext context) {
    PodfetchApiProvider client = getIt<PodfetchApiProvider>();
    final trendingPodcasts = useState<List<Podcast>?>(null);
    final isLoading = useState(true);
    final fetch =
        useMemoizedFuture(() => getIt<PodfetchApiProvider>().getTrending());

    return PageWrap(
      child: fetch.snapshot.hasData &&
              fetch.snapshot.connectionState == ConnectionState.done
          ? ListView.separated(
              itemBuilder: (_, index) {
                final podcast = fetch.snapshot.data![index];
                return ListTile(
                  title: Text(podcast.title),
                  trailing: ElevatedButton(
                    child: Text('Refetch'),
                    onPressed: () => fetch.refresh(),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: fetch.snapshot.data!.length)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );

    return PageWrap(
      title: 'Discover',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PfPageHeader(),
            const Heading(
              'Trending',
              headingType: HeadingType.h2,
            ),
            PodcastScrollList(request: client.getTrending()),
            const SizedBox(height: 80.0),
            PodcastScrollList(request: client.getTrending(language: 'de')),
            const SizedBox(height: 80.0),
          ],
        ),
      ),
    );
  }
}
