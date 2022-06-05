// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';

import 'package:podfetch_flutter/home_page.dart';
import 'package:podfetch_flutter/pages/discover_page.dart';
import 'package:podfetch_flutter/pages/flows/login/login_page.dart';
import 'package:podfetch_flutter/pages/flows/signup/email_page.dart';
import 'package:podfetch_flutter/pages/lists_page.dart';
import 'package:podfetch_flutter/pages/signup_page.dart';
import 'package:podfetch_flutter/pages/search_page.dart';
import 'package:podfetch_flutter/pages/settings_page.dart';
import 'package:podfetch_flutter/pages/single_episode_page.dart';
import 'package:podfetch_flutter/pages/single_podcast_page.dart';

import '../pages/flows/signup/password_page.dart';

const podcastRoutes = [
  AutoRoute(path: ':podcastId', page: SinglePodcastPage),
  AutoRoute(
    path: ':episodeId',
    page: SingleEpisodePage,
  ),
];

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
      page: SignupPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      path: '/signup',
      children: [
        AutoRoute(page: EmailPage),
        AutoRoute(page: PasswordPage),
      ],
    ),
    CustomRoute(
      page: LoginPage,
      transitionsBuilder: TransitionsBuilders.noTransition,
      path: '/login',
    ),
    CustomRoute(
      path: '/',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      page: HomePage,
      name: 'HomeRouter',
      children: <AutoRoute>[
        AutoRoute(
          path: '',
          name: 'DiscoverRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: DiscoverPage),
            ...podcastRoutes,
          ],
        ),
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
          path: 'lists',
          name: 'ListsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: ListsPage,
            ),
          ],
        ),
        AutoRoute(
          path: 'settings',
          name: 'SettingsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SettingsPage),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
