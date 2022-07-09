// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i16;
import 'package:podfetch_api/models/episode.dart' as _i18;
import 'package:podfetch_api/models/podcast.dart' as _i17;

import '../home_page.dart' as _i3;
import '../pages/account_page.dart' as _i13;
import '../pages/discover_page.dart' as _i7;
import '../pages/flows/login/login_page.dart' as _i2;
import '../pages/flows/signup/email_page.dart' as _i4;
import '../pages/flows/signup/password_page.dart' as _i5;
import '../pages/language_select_page.dart' as _i15;
import '../pages/lists_page.dart' as _i11;
import '../pages/search_page.dart' as _i10;
import '../pages/settings_page.dart' as _i12;
import '../pages/signup_page.dart' as _i1;
import '../pages/single_episode_page.dart' as _i9;
import '../pages/single_podcast_page.dart' as _i8;
import '../pages/storage_page.dart' as _i14;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SignupRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.SignupPage(),
          transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: _i2.LoginPage(key: args.key, onLogin: args.onLogin),
          transitionsBuilder: _i6.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    HomeRouter.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.HomePage(),
          transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>();
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i4.EmailPage(key: args.key, onNext: args.onNext));
    },
    PasswordRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordRouteArgs>();
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i5.PasswordPage(key: args.key, onNext: args.onNext));
    },
    DiscoverRouter.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.EmptyRouterPage());
    },
    SearchRouter.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.EmptyRouterPage());
    },
    ListsRouter.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.EmptyRouterPage());
    },
    DiscoverRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i7.DiscoverPage());
    },
    SinglePodcastRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SinglePodcastRouteArgs>(
          orElse: () => SinglePodcastRouteArgs(
              podcastId: pathParams.getInt('podcastId')));
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i8.SinglePodcastPage(
              key: args.key, podcast: args.podcast, podcastId: args.podcastId));
    },
    SingleEpisodeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleEpisodeRouteArgs>(
          orElse: () => SingleEpisodeRouteArgs(
              episodeId: pathParams.getInt('episodeId')));
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i9.SingleEpisodePage(
              key: args.key, episodeId: args.episodeId, episode: args.episode));
    },
    SearchRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i10.SearchPage());
    },
    ListsRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i11.ListsPage());
    },
    SettingsRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i12.SettingsPage());
    },
    AccountRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i13.AccountPage());
    },
    StorageRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i14.StoragePage());
    },
    LanguageSelectRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i15.LanguageSelectPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(SignupRoute.name, path: '/signup', children: [
          _i6.RouteConfig(EmailRoute.name,
              path: 'email-page', parent: SignupRoute.name),
          _i6.RouteConfig(PasswordRoute.name,
              path: 'password-page', parent: SignupRoute.name)
        ]),
        _i6.RouteConfig(LoginRoute.name, path: '/login'),
        _i6.RouteConfig(HomeRouter.name, path: '/', children: [
          _i6.RouteConfig(DiscoverRouter.name,
              path: '',
              parent: HomeRouter.name,
              children: [
                _i6.RouteConfig(DiscoverRoute.name,
                    path: '', parent: DiscoverRouter.name),
                _i6.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: DiscoverRouter.name),
                _i6.RouteConfig(SingleEpisodeRoute.name,
                    path: ':episodeId', parent: DiscoverRouter.name)
              ]),
          _i6.RouteConfig(SearchRouter.name,
              path: 'search',
              parent: HomeRouter.name,
              children: [
                _i6.RouteConfig(SearchRoute.name,
                    path: '', parent: SearchRouter.name),
                _i6.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: SearchRouter.name),
                _i6.RouteConfig(SingleEpisodeRoute.name,
                    path: ':episodeId', parent: SearchRouter.name)
              ]),
          _i6.RouteConfig(ListsRouter.name,
              path: 'lists',
              parent: HomeRouter.name,
              children: [
                _i6.RouteConfig(ListsRoute.name,
                    path: '', parent: ListsRouter.name)
              ]),
          _i6.RouteConfig(SettingsRouter.name,
              path: 'settings',
              parent: HomeRouter.name,
              children: [
                _i6.RouteConfig(SettingsRoute.name,
                    path: '', parent: SettingsRouter.name),
                _i6.RouteConfig(AccountRoute.name,
                    path: 'account', parent: SettingsRouter.name),
                _i6.RouteConfig(StorageRoute.name,
                    path: 'storage', parent: SettingsRouter.name),
                _i6.RouteConfig(LanguageSelectRoute.name,
                    path: 'language-select', parent: SettingsRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.SignupPage]
class SignupRoute extends _i6.PageRouteInfo<void> {
  const SignupRoute({List<_i6.PageRouteInfo>? children})
      : super(SignupRoute.name, path: '/signup', initialChildren: children);

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i16.Key? key, required dynamic Function() onLogin})
      : super(LoginRoute.name,
            path: '/login', args: LoginRouteArgs(key: key, onLogin: onLogin));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onLogin});

  final _i16.Key? key;

  final dynamic Function() onLogin;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLogin: $onLogin}';
  }
}

/// generated route for
/// [_i3.HomePage]
class HomeRouter extends _i6.PageRouteInfo<void> {
  const HomeRouter({List<_i6.PageRouteInfo>? children})
      : super(HomeRouter.name, path: '/', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i4.EmailPage]
class EmailRoute extends _i6.PageRouteInfo<EmailRouteArgs> {
  EmailRoute({_i16.Key? key, required dynamic Function(String) onNext})
      : super(EmailRoute.name,
            path: 'email-page', args: EmailRouteArgs(key: key, onNext: onNext));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, required this.onNext});

  final _i16.Key? key;

  final dynamic Function(String) onNext;

  @override
  String toString() {
    return 'EmailRouteArgs{key: $key, onNext: $onNext}';
  }
}

/// generated route for
/// [_i5.PasswordPage]
class PasswordRoute extends _i6.PageRouteInfo<PasswordRouteArgs> {
  PasswordRoute({_i16.Key? key, required dynamic Function(String) onNext})
      : super(PasswordRoute.name,
            path: 'password-page',
            args: PasswordRouteArgs(key: key, onNext: onNext));

  static const String name = 'PasswordRoute';
}

class PasswordRouteArgs {
  const PasswordRouteArgs({this.key, required this.onNext});

  final _i16.Key? key;

  final dynamic Function(String) onNext;

  @override
  String toString() {
    return 'PasswordRouteArgs{key: $key, onNext: $onNext}';
  }
}

/// generated route for
/// [_i6.EmptyRouterPage]
class DiscoverRouter extends _i6.PageRouteInfo<void> {
  const DiscoverRouter({List<_i6.PageRouteInfo>? children})
      : super(DiscoverRouter.name, path: '', initialChildren: children);

  static const String name = 'DiscoverRouter';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class SearchRouter extends _i6.PageRouteInfo<void> {
  const SearchRouter({List<_i6.PageRouteInfo>? children})
      : super(SearchRouter.name, path: 'search', initialChildren: children);

  static const String name = 'SearchRouter';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class ListsRouter extends _i6.PageRouteInfo<void> {
  const ListsRouter({List<_i6.PageRouteInfo>? children})
      : super(ListsRouter.name, path: 'lists', initialChildren: children);

  static const String name = 'ListsRouter';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class SettingsRouter extends _i6.PageRouteInfo<void> {
  const SettingsRouter({List<_i6.PageRouteInfo>? children})
      : super(SettingsRouter.name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i7.DiscoverPage]
class DiscoverRoute extends _i6.PageRouteInfo<void> {
  const DiscoverRoute() : super(DiscoverRoute.name, path: '');

  static const String name = 'DiscoverRoute';
}

/// generated route for
/// [_i8.SinglePodcastPage]
class SinglePodcastRoute extends _i6.PageRouteInfo<SinglePodcastRouteArgs> {
  SinglePodcastRoute(
      {_i16.Key? key, _i17.Podcast? podcast, required int podcastId})
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

  final _i16.Key? key;

  final _i17.Podcast? podcast;

  final int podcastId;

  @override
  String toString() {
    return 'SinglePodcastRouteArgs{key: $key, podcast: $podcast, podcastId: $podcastId}';
  }
}

/// generated route for
/// [_i9.SingleEpisodePage]
class SingleEpisodeRoute extends _i6.PageRouteInfo<SingleEpisodeRouteArgs> {
  SingleEpisodeRoute(
      {_i16.Key? key, required int episodeId, _i18.Episode? episode})
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

  final _i16.Key? key;

  final int episodeId;

  final _i18.Episode? episode;

  @override
  String toString() {
    return 'SingleEpisodeRouteArgs{key: $key, episodeId: $episodeId, episode: $episode}';
  }
}

/// generated route for
/// [_i10.SearchPage]
class SearchRoute extends _i6.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i11.ListsPage]
class ListsRoute extends _i6.PageRouteInfo<void> {
  const ListsRoute() : super(ListsRoute.name, path: '');

  static const String name = 'ListsRoute';
}

/// generated route for
/// [_i12.SettingsPage]
class SettingsRoute extends _i6.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i13.AccountPage]
class AccountRoute extends _i6.PageRouteInfo<void> {
  const AccountRoute() : super(AccountRoute.name, path: 'account');

  static const String name = 'AccountRoute';
}

/// generated route for
/// [_i14.StoragePage]
class StorageRoute extends _i6.PageRouteInfo<void> {
  const StorageRoute() : super(StorageRoute.name, path: 'storage');

  static const String name = 'StorageRoute';
}

/// generated route for
/// [_i15.LanguageSelectPage]
class LanguageSelectRoute extends _i6.PageRouteInfo<void> {
  const LanguageSelectRoute()
      : super(LanguageSelectRoute.name, path: 'language-select');

  static const String name = 'LanguageSelectRoute';
}
