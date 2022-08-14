// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i19;
import 'package:podfetch_api/models/episode.dart' as _i21;
import 'package:podfetch_api/models/podcast.dart' as _i20;

import '../home_page.dart' as _i2;
import '../pages/account_page.dart' as _i16;
import '../pages/categories/single_category_page.dart' as _i11;
import '../pages/discover_page.dart' as _i12;
import '../pages/flows/login/login_page.dart' as _i4;
import '../pages/flows/onboarding_page.dart' as _i3;
import '../pages/flows/signup/choose_categories_page.dart' as _i7;
import '../pages/flows/signup/create_account_page.dart' as _i5;
import '../pages/flows/signup/new_account_page.dart' as _i6;
import '../pages/language_select_page.dart' as _i18;
import '../pages/lists_page.dart' as _i14;
import '../pages/personal_page.dart' as _i8;
import '../pages/search_page.dart' as _i13;
import '../pages/settings_page.dart' as _i15;
import '../pages/single_episode_page.dart' as _i10;
import '../pages/single_podcast_page.dart' as _i9;
import '../pages/storage_page.dart' as _i17;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i19.GlobalKey<_i19.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    OnboardingRouter.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.EmptyRouterPage(),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    HomeRouter.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.HomePage(),
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    OnboardingRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i3.OnboardingPage());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i4.LoginPage(key: args.key, onLogin: args.onLogin));
    },
    CreateAccountRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.CreateAccountPage());
    },
    NewAccountRoute.name: (routeData) {
      final args = routeData.argsAs<NewAccountRouteArgs>();
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i6.NewAccountPage(key: args.key, onNext: args.onNext));
    },
    ChooseCategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<ChooseCategoriesRouteArgs>();
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i7.ChooseCategoriesPage(key: args.key, onNext: args.onNext));
    },
    PersonalRouter.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    DiscoverRouter.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    SearchRouter.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    ListsRouter.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    PersonalRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i8.PersonalPage());
    },
    SinglePodcastRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SinglePodcastRouteArgs>(
          orElse: () => SinglePodcastRouteArgs(
              podcastId: pathParams.getInt('podcastId')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i9.SinglePodcastPage(
              key: args.key, podcast: args.podcast, podcastId: args.podcastId));
    },
    SingleEpisodeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleEpisodeRouteArgs>(
          orElse: () => SingleEpisodeRouteArgs(
              episodeId: pathParams.getInt('episodeId')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i10.SingleEpisodePage(
              key: args.key, episodeId: args.episodeId, episode: args.episode));
    },
    SingleCategoryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleCategoryRouteArgs>(
          orElse: () => SingleCategoryRouteArgs(
              categoryId: pathParams.getInt('categoryId')));
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i11.SingleCategoryPage(
              key: args.key, categoryId: args.categoryId));
    },
    DiscoverRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i12.DiscoverPage());
    },
    SearchRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i13.SearchPage());
    },
    ListsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i14.ListsPage());
    },
    SettingsRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i15.SettingsPage());
    },
    AccountRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i16.AccountPage());
    },
    StorageRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i17.StoragePage());
    },
    LanguageSelectRoute.name: (routeData) {
      return _i1.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i18.LanguageSelectPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(OnboardingRouter.name, path: '/onboarding', children: [
          _i1.RouteConfig(OnboardingRoute.name,
              path: '', parent: OnboardingRouter.name),
          _i1.RouteConfig(LoginRoute.name,
              path: 'login', parent: OnboardingRouter.name),
          _i1.RouteConfig(CreateAccountRoute.name,
              path: 'create-account',
              parent: OnboardingRouter.name,
              children: [
                _i1.RouteConfig(NewAccountRoute.name,
                    path: 'new-account-page', parent: CreateAccountRoute.name),
                _i1.RouteConfig(ChooseCategoriesRoute.name,
                    path: 'choose-categories-page',
                    parent: CreateAccountRoute.name)
              ])
        ]),
        _i1.RouteConfig(HomeRouter.name, path: '/', children: [
          _i1.RouteConfig(PersonalRouter.name,
              path: '',
              parent: HomeRouter.name,
              children: [
                _i1.RouteConfig(PersonalRoute.name,
                    path: '', parent: PersonalRouter.name),
                _i1.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: PersonalRouter.name),
                _i1.RouteConfig(SingleEpisodeRoute.name,
                    path: ':episodeId', parent: PersonalRouter.name),
                _i1.RouteConfig(SingleCategoryRoute.name,
                    path: ':categoryId', parent: PersonalRouter.name)
              ]),
          _i1.RouteConfig(DiscoverRouter.name,
              path: 'discover',
              parent: HomeRouter.name,
              children: [
                _i1.RouteConfig(DiscoverRoute.name,
                    path: '', parent: DiscoverRouter.name),
                _i1.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: DiscoverRouter.name),
                _i1.RouteConfig(SingleEpisodeRoute.name,
                    path: ':episodeId', parent: DiscoverRouter.name),
                _i1.RouteConfig(SingleCategoryRoute.name,
                    path: ':categoryId', parent: DiscoverRouter.name)
              ]),
          _i1.RouteConfig(SearchRouter.name,
              path: 'search',
              parent: HomeRouter.name,
              children: [
                _i1.RouteConfig(SearchRoute.name,
                    path: '', parent: SearchRouter.name),
                _i1.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: SearchRouter.name),
                _i1.RouteConfig(SingleEpisodeRoute.name,
                    path: ':episodeId', parent: SearchRouter.name),
                _i1.RouteConfig(SingleCategoryRoute.name,
                    path: ':categoryId', parent: SearchRouter.name)
              ]),
          _i1.RouteConfig(ListsRouter.name,
              path: 'lists',
              parent: HomeRouter.name,
              children: [
                _i1.RouteConfig(ListsRoute.name,
                    path: '', parent: ListsRouter.name),
                _i1.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: ListsRouter.name),
                _i1.RouteConfig(SingleEpisodeRoute.name,
                    path: ':episodeId', parent: ListsRouter.name)
              ]),
          _i1.RouteConfig(SettingsRouter.name,
              path: 'settings',
              parent: HomeRouter.name,
              children: [
                _i1.RouteConfig(SettingsRoute.name,
                    path: '', parent: SettingsRouter.name),
                _i1.RouteConfig(AccountRoute.name,
                    path: 'account', parent: SettingsRouter.name),
                _i1.RouteConfig(StorageRoute.name,
                    path: 'storage', parent: SettingsRouter.name),
                _i1.RouteConfig(LanguageSelectRoute.name,
                    path: 'language-select', parent: SettingsRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class OnboardingRouter extends _i1.PageRouteInfo<void> {
  const OnboardingRouter({List<_i1.PageRouteInfo>? children})
      : super(OnboardingRouter.name,
            path: '/onboarding', initialChildren: children);

  static const String name = 'OnboardingRouter';
}

/// generated route for
/// [_i2.HomePage]
class HomeRouter extends _i1.PageRouteInfo<void> {
  const HomeRouter({List<_i1.PageRouteInfo>? children})
      : super(HomeRouter.name, path: '/', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i3.OnboardingPage]
class OnboardingRoute extends _i1.PageRouteInfo<void> {
  const OnboardingRoute() : super(OnboardingRoute.name, path: '');

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i1.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i19.Key? key, dynamic Function()? onLogin})
      : super(LoginRoute.name,
            path: 'login', args: LoginRouteArgs(key: key, onLogin: onLogin));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLogin});

  final _i19.Key? key;

  final dynamic Function()? onLogin;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLogin: $onLogin}';
  }
}

/// generated route for
/// [_i5.CreateAccountPage]
class CreateAccountRoute extends _i1.PageRouteInfo<void> {
  const CreateAccountRoute({List<_i1.PageRouteInfo>? children})
      : super(CreateAccountRoute.name,
            path: 'create-account', initialChildren: children);

  static const String name = 'CreateAccountRoute';
}

/// generated route for
/// [_i6.NewAccountPage]
class NewAccountRoute extends _i1.PageRouteInfo<NewAccountRouteArgs> {
  NewAccountRoute(
      {_i19.Key? key, required dynamic Function(String, String) onNext})
      : super(NewAccountRoute.name,
            path: 'new-account-page',
            args: NewAccountRouteArgs(key: key, onNext: onNext));

  static const String name = 'NewAccountRoute';
}

class NewAccountRouteArgs {
  const NewAccountRouteArgs({this.key, required this.onNext});

  final _i19.Key? key;

  final dynamic Function(String, String) onNext;

  @override
  String toString() {
    return 'NewAccountRouteArgs{key: $key, onNext: $onNext}';
  }
}

/// generated route for
/// [_i7.ChooseCategoriesPage]
class ChooseCategoriesRoute
    extends _i1.PageRouteInfo<ChooseCategoriesRouteArgs> {
  ChooseCategoriesRoute(
      {_i19.Key? key, required dynamic Function(List<String?>) onNext})
      : super(ChooseCategoriesRoute.name,
            path: 'choose-categories-page',
            args: ChooseCategoriesRouteArgs(key: key, onNext: onNext));

  static const String name = 'ChooseCategoriesRoute';
}

class ChooseCategoriesRouteArgs {
  const ChooseCategoriesRouteArgs({this.key, required this.onNext});

  final _i19.Key? key;

  final dynamic Function(List<String?>) onNext;

  @override
  String toString() {
    return 'ChooseCategoriesRouteArgs{key: $key, onNext: $onNext}';
  }
}

/// generated route for
/// [_i1.EmptyRouterPage]
class PersonalRouter extends _i1.PageRouteInfo<void> {
  const PersonalRouter({List<_i1.PageRouteInfo>? children})
      : super(PersonalRouter.name, path: '', initialChildren: children);

  static const String name = 'PersonalRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class DiscoverRouter extends _i1.PageRouteInfo<void> {
  const DiscoverRouter({List<_i1.PageRouteInfo>? children})
      : super(DiscoverRouter.name, path: 'discover', initialChildren: children);

  static const String name = 'DiscoverRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class SearchRouter extends _i1.PageRouteInfo<void> {
  const SearchRouter({List<_i1.PageRouteInfo>? children})
      : super(SearchRouter.name, path: 'search', initialChildren: children);

  static const String name = 'SearchRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class ListsRouter extends _i1.PageRouteInfo<void> {
  const ListsRouter({List<_i1.PageRouteInfo>? children})
      : super(ListsRouter.name, path: 'lists', initialChildren: children);

  static const String name = 'ListsRouter';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class SettingsRouter extends _i1.PageRouteInfo<void> {
  const SettingsRouter({List<_i1.PageRouteInfo>? children})
      : super(SettingsRouter.name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i8.PersonalPage]
class PersonalRoute extends _i1.PageRouteInfo<void> {
  const PersonalRoute() : super(PersonalRoute.name, path: '');

  static const String name = 'PersonalRoute';
}

/// generated route for
/// [_i9.SinglePodcastPage]
class SinglePodcastRoute extends _i1.PageRouteInfo<SinglePodcastRouteArgs> {
  SinglePodcastRoute(
      {_i19.Key? key, _i20.Podcast? podcast, required int podcastId})
      : super(SinglePodcastRoute.name,
            path: ':podcastId',
            args: SinglePodcastRouteArgs(
                key: key, podcast: podcast, podcastId: podcastId),
            rawPathParams: {'podcastId': podcastId});

  static const String name = 'SinglePodcastRoute';
}

class SinglePodcastRouteArgs {
  const SinglePodcastRouteArgs(
      {this.key, this.podcast, required this.podcastId});

  final _i19.Key? key;

  final _i20.Podcast? podcast;

  final int podcastId;

  @override
  String toString() {
    return 'SinglePodcastRouteArgs{key: $key, podcast: $podcast, podcastId: $podcastId}';
  }
}

/// generated route for
/// [_i10.SingleEpisodePage]
class SingleEpisodeRoute extends _i1.PageRouteInfo<SingleEpisodeRouteArgs> {
  SingleEpisodeRoute(
      {_i19.Key? key, required int episodeId, _i21.Episode? episode})
      : super(SingleEpisodeRoute.name,
            path: ':episodeId',
            args: SingleEpisodeRouteArgs(
                key: key, episodeId: episodeId, episode: episode),
            rawPathParams: {'episodeId': episodeId});

  static const String name = 'SingleEpisodeRoute';
}

class SingleEpisodeRouteArgs {
  const SingleEpisodeRouteArgs(
      {this.key, required this.episodeId, this.episode});

  final _i19.Key? key;

  final int episodeId;

  final _i21.Episode? episode;

  @override
  String toString() {
    return 'SingleEpisodeRouteArgs{key: $key, episodeId: $episodeId, episode: $episode}';
  }
}

/// generated route for
/// [_i11.SingleCategoryPage]
class SingleCategoryRoute extends _i1.PageRouteInfo<SingleCategoryRouteArgs> {
  SingleCategoryRoute({_i19.Key? key, required int categoryId})
      : super(SingleCategoryRoute.name,
            path: ':categoryId',
            args: SingleCategoryRouteArgs(key: key, categoryId: categoryId),
            rawPathParams: {'categoryId': categoryId});

  static const String name = 'SingleCategoryRoute';
}

class SingleCategoryRouteArgs {
  const SingleCategoryRouteArgs({this.key, required this.categoryId});

  final _i19.Key? key;

  final int categoryId;

  @override
  String toString() {
    return 'SingleCategoryRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i12.DiscoverPage]
class DiscoverRoute extends _i1.PageRouteInfo<void> {
  const DiscoverRoute() : super(DiscoverRoute.name, path: '');

  static const String name = 'DiscoverRoute';
}

/// generated route for
/// [_i13.SearchPage]
class SearchRoute extends _i1.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i14.ListsPage]
class ListsRoute extends _i1.PageRouteInfo<void> {
  const ListsRoute() : super(ListsRoute.name, path: '');

  static const String name = 'ListsRoute';
}

/// generated route for
/// [_i15.SettingsPage]
class SettingsRoute extends _i1.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i16.AccountPage]
class AccountRoute extends _i1.PageRouteInfo<void> {
  const AccountRoute() : super(AccountRoute.name, path: 'account');

  static const String name = 'AccountRoute';
}

/// generated route for
/// [_i17.StoragePage]
class StorageRoute extends _i1.PageRouteInfo<void> {
  const StorageRoute() : super(StorageRoute.name, path: 'storage');

  static const String name = 'StorageRoute';
}

/// generated route for
/// [_i18.LanguageSelectPage]
class LanguageSelectRoute extends _i1.PageRouteInfo<void> {
  const LanguageSelectRoute()
      : super(LanguageSelectRoute.name, path: 'language-select');

  static const String name = 'LanguageSelectRoute';
}
