import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/responses/search_response.dart';
import 'package:podfetch_flutter/widgets/utils/network.dart';

import '../providers.dart';
import '../widgets/search/search_result_podcast_item.dart';
import '../widgets/utils/page_container.dart';

class PodfetchSearchDelegate extends SearchDelegate {
  final WidgetRef ref;

  PodfetchSearchDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(BootstrapIcons.x),
        ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(BootstrapIcons.arrow_left),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder(
        future: ref.watch(apiProvider).search(query),
        builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
          if (snapshot.isReady) {
            final podcasts = snapshot.data!.podcasts;
            if (podcasts != null && podcasts.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 0),
                primary: false,
                shrinkWrap: true,
                itemBuilder: (_, int index) {
                  final podcast = podcasts[index];
                  return SearchResultPodcastItem(
                    podcast: podcast,
                    beforeNavigate: () => close(context, null),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 8.0),
                itemCount: podcasts.length,
              );
            }

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    BootstrapIcons.search,
                    size: 64,
                  ),
                  const SizedBox(height: 16.0),
                  Text('No results for "$query".')
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(top: 0),
            primary: false,
            shrinkWrap: true,
            itemBuilder: (_, int index) {
              return const SearchResultPodcastItemSkeleton();
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8.0),
            itemCount: 4,
          );
        },
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            BootstrapIcons.search,
            size: 64,
          ),
          SizedBox(height: 16.0),
          Text('No results.')
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return FutureBuilder(
        future: ref.watch(apiProvider).search(query),
        builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
          if (snapshot.isReady) {
            final podcasts = snapshot.data!.podcasts;
            return ListView.separated(
              padding: const EdgeInsets.only(top: 0),
              primary: false,
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                final podcast = podcasts![index];
                return ListTile(
                  title: Text(podcast.title.toLowerCase()),
                  onTap: () {
                    final currentQuery = podcast.title.toLowerCase();
                    final box = Hive.box('recentSearches');
                    if (!box.values.contains(currentQuery)) {
                      box.add(currentQuery);
                    }
                    query = currentQuery;
                    showResults(context);
                  },
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: podcasts?.length ?? 0,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return RecentSearches(
      onSuggestionTap: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }
}

class RecentSearches extends HookWidget {
  const RecentSearches({Key? key, required this.onSuggestionTap})
      : super(key: key);

  final void Function(String) onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('recentSearches');
    final recents = useState(box.values.toList().cast<String>());

    if (recents.value.isNotEmpty) {
      return Column(
        children: [
          PageContainer(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  recents.value = [];
                  box.clear();
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).highlightColor),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                child: const Text('Clear all'),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 0),
              primary: false,
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                final suggestion = recents.value[index];
                return ListTile(
                  leading: const Icon(
                    BootstrapIcons.clock_history,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      box.deleteAt(index);
                      final newList = [...recents.value];
                      newList.removeAt(index);
                      recents.value = newList;
                    },
                    child: const Icon(BootstrapIcons.x),
                  ),
                  title: Text(suggestion),
                  onTap: () => onSuggestionTap(suggestion),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: recents.value.length,
            ),
          ),
        ],
      );
    }

    return const Center(
      child: Icon(
        BootstrapIcons.search,
        size: 64,
      ),
    );
  }
}
