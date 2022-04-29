import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_api/responses/search_response.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/service_locator.dart';

import '../../widgets/buttons/icon_button.dart';

class PfSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 16.0),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: const TextStyle(fontSize: 16.0),
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Visibility(
        visible: query.isNotEmpty,
        child: PfIconButton(
          icon: const Icon(
            Icons.clear,
            size: 20.0,
          ),
          onPressed: () {
            query = '';
          },
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return PfIconButton(
      icon: const Icon(BootstrapIcons.arrow_left),
      onPressed: () {
        context.router.popTop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
        future: getIt<PodfetchApiProvider>().search(query),
        builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
          if (snapshot.hasData) {
            final _searchResult = snapshot.data!;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_searchResult.podcasts?[index].title ?? 'error'),
                  onTap: () {
                    context.router.popUntilRoot();
                    context.navigateTo(HomeRouter(children: [
                      DiscoverRouter(children: [
                        SinglePodcastRoute(
                            podcast: _searchResult.podcasts?[index])
                      ])
                    ]));
                    /*  context.router.replaceAll([
                  HomeRouter(children: [
                    DiscoverRouter(children: [SinglePodcastRoute()])
                  ])
                ]); */
                  },
                );
              },
              itemCount: _searchResult.podcasts?.length,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Suggestion $index'),
          onTap: () {
            query = 'Suggestion $index';
          },
        );
      },
      itemCount: 10,
    );
  }
}
