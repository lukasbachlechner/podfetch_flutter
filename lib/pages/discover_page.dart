import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
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

    return PageWrap(
      title: 'Discover',
      child: RefreshIndicator(
        onRefresh: () {
          discoverRequestKey.value = UniqueKey();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: ClampingScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PfSpacer.top(),
              const Heading(
                'Trending',
                headingType: HeadingType.h2,
              ),
              PodcastScrollList(
                request: client.getTrending(),
                requestKey: discoverRequestKey.value,
              ),
              const SizedBox(height: 80.0),
              PodcastScrollList(
                request: client.getTrending(language: 'de'),
                requestKey: discoverRequestKey.value,
              ),
              const SizedBox(height: 80.0),
            ],
          ),
        ),
      ),
    );
  }
}
