// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:podfetch_flutter/home_page.dart';
import 'package:podfetch_flutter/pages/categories/single_category_page.dart';
import 'package:podfetch_flutter/pages/discover_page.dart';
import 'package:podfetch_flutter/pages/flows/login/login_page.dart';
import 'package:podfetch_flutter/pages/flows/onboarding_page.dart';
import 'package:podfetch_flutter/pages/flows/signup/choose_categories_page.dart';
import 'package:podfetch_flutter/pages/flows/signup/create_account_page.dart';
import 'package:podfetch_flutter/pages/flows/signup/new_account_page.dart';
import 'package:podfetch_flutter/pages/language_select_page.dart';
import 'package:podfetch_flutter/pages/lists_page.dart';
import 'package:podfetch_flutter/pages/personal_page.dart';
import 'package:podfetch_flutter/pages/search_page.dart';
import 'package:podfetch_flutter/pages/settings_page.dart';
import 'package:podfetch_flutter/pages/signup_page.dart';
import 'package:podfetch_flutter/pages/single_episode_page.dart';
import 'package:podfetch_flutter/pages/single_podcast_page.dart';
import 'package:podfetch_flutter/pages/storage_page.dart';

import '../pages/account_page.dart';
import '../pages/flows/signup/password_page.dart';

const podcastRoutes = [
  AutoRoute(path: ':podcastId', page: SinglePodcastPage),
  AutoRoute(path: ':episodeId', page: SingleEpisodePage),
];

const categoryRoute = AutoRoute(path: ':categoryId', page: SingleCategoryPage);

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    /*  CustomRoute(
      page: SignupPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      path: '/signup',
      children: [
        AutoRoute(page: EmailPage),
        AutoRoute(page: PasswordPage),
      ],
    ), */
    CustomRoute(
      page: EmptyRouterPage,
      name: 'OnboardingRouter',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      path: '/onboarding',
      children: [
        AutoRoute(page: OnboardingPage, path: ''),
        AutoRoute(page: LoginPage, path: 'login'),
        AutoRoute(page: CreateAccountPage, path: 'create-account', children: [
          AutoRoute(page: NewAccountPage),
          AutoRoute(page: ChooseCategoriesPage),
        ]),
        // AutoRoute(page: SignupPage, path: 'signup'),
      ],
    ),
    CustomRoute(
      path: '/',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      page: HomePage,
      name: 'HomeRouter',
      children: <AutoRoute>[
        AutoRoute(
          path: '',
          name: 'PersonalRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: PersonalPage),
            ...podcastRoutes,
            categoryRoute
          ],
        ),
        AutoRoute(
          path: 'discover',
          name: 'DiscoverRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: DiscoverPage),
            ...podcastRoutes,
            categoryRoute
          ],
        ),
        AutoRoute(
          path: 'search',
          name: 'SearchRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SearchPage),
            ...podcastRoutes,
            categoryRoute
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
            ...podcastRoutes,
          ],
        ),
        AutoRoute(
          path: 'settings',
          name: 'SettingsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: SettingsPage),
            AutoRoute(path: 'account', page: AccountPage),
            AutoRoute(path: 'storage', page: StoragePage),
            AutoRoute(path: 'language-select', page: LanguageSelectPage)
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
