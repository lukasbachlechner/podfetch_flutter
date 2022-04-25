// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:podfetch_flutter/home_page.dart';
import 'package:podfetch_flutter/pages/discover_page.dart';
import 'package:podfetch_flutter/pages/not_yet_page.dart';
import 'package:podfetch_flutter/pages/search_page.dart';
import 'package:podfetch_flutter/pages/single_podcast_page.dart';

const podcastRoutes = [
  AutoRoute(path: ':podcastId', page: SinglePodcastPage),
];

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomePage,
      name: 'HomeRouter',
      children: <AutoRoute>[
        AutoRoute(
          path: 'search',
          name: 'SearchRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SearchPage),
            ...podcastRoutes,
          ],
        ),
        AutoRoute(
          path: 'podcasts',
          name: 'DiscoverRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: DiscoverPage),
            ...podcastRoutes,
          ],
        ),
        AutoRoute(
          path: 'liked',
          name: 'LikedRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: NotYetPage),
          ],
        ),
        AutoRoute(
          path: 'categories',
          name: 'CategoriesRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: NotYetPage),
          ],
        ),
        AutoRoute(
          path: 'downloads',
          name: 'DownloadsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: NotYetPage),
          ],
        ),
        AutoRoute(
          path: 'settings',
          name: 'SettingsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: NotYetPage),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
