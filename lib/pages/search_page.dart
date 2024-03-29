import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/responses/search_response.dart';
import 'package:podfetch_flutter/widgets/base/app_bar.dart';
import 'package:podfetch_flutter/widgets/utils/network.dart';
import '../hooks/use_memoized_future.dart';
import '../providers.dart';
import '../providers/api_provider.dart';
import '../theme.dart';
import '../widgets/buttons/icon_button.dart';
import '../widgets/categories/categories_grid.dart';
import '../widgets/page/page_header.dart';
import '../widgets/search/search_result_podcast_item.dart';
import '../widgets/typography/heading.dart';
import '../widgets/utils/page_container.dart';
import '../widgets/base/page_wrap.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const minQueryLength = 2;

  Future<SearchResponse> _search(String query, WidgetRef ref) {
    if (query.isNotEmpty && query.length > minQueryLength) {
      return ref.watch(apiProvider).search(query);
    }

    return Future.sync(() => const EmptySearchResponse());
  }

  Widget _showResults(AsyncSnapshot<SearchResponse> snapshot, String query) {
    if (snapshot.hasData &&
        snapshot.data is EmptySearchResponse &&
        query.isNotEmpty) {
      return const Center(
        child:
            Text('Please provide at least ${minQueryLength + 1} characters.'),
      );
    }

    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
      final podcasts = snapshot.data!.podcasts;
      return PageContainer(
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 0),
          primary: false,
          shrinkWrap: true,
          itemBuilder: (_, int index) {
            final podcast = podcasts![index];
            return SearchResultPodcastItem(podcast: podcast);
          },
          separatorBuilder: (_, __) => const SizedBox(
            height: 8.0,
          ),
          itemCount: podcasts?.length ?? 0,
        ),
      );
    }

    return PageContainer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0),
        primary: false,
        shrinkWrap: true,
        itemBuilder: (_, int index) {
          return const SearchResultPodcastItemSkeleton();
        },
        separatorBuilder: (_, __) => const SizedBox(
          height: 8.0,
        ),
        itemCount: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final focusNode = useFocusNode();
    final isSearchFocused = useState<bool>(false);

    final query = useState<String>('');

    final searchFetch = useMemoizedFuture<SearchResponse>(
      () => _search(query.value, ref),
      keys: [query.value],
    );

    focusNode.addListener(() {
      isSearchFocused.value = focusNode.hasFocus;
    });

    return PageWrap(
      children: [
        const Heading(
          'Search',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kPagePadding,
            vertical: 16.0,
          ),
          child: TextField(
            onChanged: (value) => query.value = value,
            controller: textEditingController,
            focusNode: focusNode,
            autofocus: false,
            decoration: InputDecoration(
              prefixIcon: AnimatedSwitcher(
                duration: const Duration(),
                child:
                    searchFetch.snapshot.connectionState != ConnectionState.done
                        ? const Center(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: SizedBox(
                              width: 16.0,
                              height: 16.0,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0,
                              ),
                            ),
                          )
                        : const Icon(BootstrapIcons.search, size: 16.0),
              ),
              suffixIcon: Visibility(
                visible: query.value.isNotEmpty,
                child: PfIconButton(
                  onPressed: () {
                    textEditingController.text = '';
                    query.value = '';
                  },
                  icon: const Icon(BootstrapIcons.x),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: isSearchFocused.value || query.value.isNotEmpty
                ? _showResults(searchFetch.snapshot, query.value)
                : const CategoriesGrid(
                    columnCount: 2,
                    aspectRatio: 2 / 1,
                  ),
          ),
        ),
      ],
    );
  }
}
