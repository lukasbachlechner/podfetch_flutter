// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i11;
import 'package:podfetch_api/models/podcast.dart' as _i12;

import '../home_page.dart' as _i2;
import '../pages/discover_page.dart' as _i6;
import '../pages/flows/signup/email_page.dart' as _i3;
import '../pages/flows/signup/password_page.dart' as _i4;
import '../pages/lists_page.dart' as _i9;
import '../pages/login_page.dart' as _i1;
import '../pages/search_page.dart' as _i8;
import '../pages/settings_page.dart' as _i10;
import '../pages/single_podcast_page.dart' as _i7;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.LoginPage(),
          transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    HomeRouter.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.HomePage(),
          transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    EmailRoute.name: (routeData) {
      final args = routeData.argsAs<EmailRouteArgs>();
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i3.EmailPage(key: args.key, onNext: args.onNext));
    },
    PasswordRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordRouteArgs>();
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i4.PasswordPage(key: args.key, onNext: args.onNext));
    },
    DiscoverRouter.name: (routeData) {
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    SearchRouter.name: (routeData) {
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    ListsRouter.name: (routeData) {
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.EmptyRouterPage());
    },
    DiscoverRoute.name: (routeData) {
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.DiscoverPage());
    },
    SinglePodcastRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SinglePodcastRouteArgs>(
          orElse: () => SinglePodcastRouteArgs(
              podcastId: pathParams.optInt('podcastId')));
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData,
          child: _i7.SinglePodcastPage(
              key: args.key, podcast: args.podcast, podcastId: args.podcastId));
    },
    SearchRoute.name: (routeData) {
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i8.SearchPage());
    },
    ListsRoute.name: (routeData) {
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i9.ListsPage());
    },
    SettingsRoute.name: (routeData) {
      return _i5.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i10.SettingsPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(LoginRoute.name, path: '/login', children: [
          _i5.RouteConfig(EmailRoute.name,
              path: 'email-page', parent: LoginRoute.name),
          _i5.RouteConfig(PasswordRoute.name,
              path: 'password-page', parent: LoginRoute.name)
        ]),
        _i5.RouteConfig(HomeRouter.name, path: '/', children: [
          _i5.RouteConfig(DiscoverRouter.name,
              path: '',
              parent: HomeRouter.name,
              children: [
                _i5.RouteConfig(DiscoverRoute.name,
                    path: '', parent: DiscoverRouter.name),
                _i5.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: DiscoverRouter.name)
              ]),
          _i5.RouteConfig(SearchRouter.name,
              path: 'search',
              parent: HomeRouter.name,
              children: [
                _i5.RouteConfig(SearchRoute.name,
                    path: '', parent: SearchRouter.name),
                _i5.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: SearchRouter.name)
              ]),
          _i5.RouteConfig(ListsRouter.name,
              path: 'lists',
              parent: HomeRouter.name,
              children: [
                _i5.RouteConfig(ListsRoute.name,
                    path: '', parent: ListsRouter.name)
              ]),
          _i5.RouteConfig(SettingsRouter.name,
              path: 'settings',
              parent: HomeRouter.name,
              children: [
                _i5.RouteConfig(SettingsRoute.name,
                    path: '', parent: SettingsRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(LoginRoute.name, path: '/login', initialChildren: children);

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRouter extends _i5.PageRouteInfo<void> {
  const HomeRouter({List<_i5.PageRouteInfo>? children})
      : super(HomeRouter.name, path: '/', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i3.EmailPage]
class EmailRoute extends _i5.PageRouteInfo<EmailRouteArgs> {
  EmailRoute({_i11.Key? key, required dynamic Function(String) onNext})
      : super(EmailRoute.name,
            path: 'email-page', args: EmailRouteArgs(key: key, onNext: onNext));

  static const String name = 'EmailRoute';
}

class EmailRouteArgs {
  const EmailRouteArgs({this.key, required this.onNext});

  final _i11.Key? key;

  final dynamic Function(String) onNext;

  @override
  String toString() {
    return 'EmailRouteArgs{key: $key, onNext: $onNext}';
  }
}

/// generated route for
/// [_i4.PasswordPage]
class PasswordRoute extends _i5.PageRouteInfo<PasswordRouteArgs> {
  PasswordRoute({_i11.Key? key, required dynamic Function(String) onNext})
      : super(PasswordRoute.name,
            path: 'password-page',
            args: PasswordRouteArgs(key: key, onNext: onNext));

  static const String name = 'PasswordRoute';
}

class PasswordRouteArgs {
  const PasswordRouteArgs({this.key, required this.onNext});

  final _i11.Key? key;

  final dynamic Function(String) onNext;

  @override
  String toString() {
    return 'PasswordRouteArgs{key: $key, onNext: $onNext}';
  }
}

/// generated route for
/// [_i5.EmptyRouterPage]
class DiscoverRouter extends _i5.PageRouteInfo<void> {
  const DiscoverRouter({List<_i5.PageRouteInfo>? children})
      : super(DiscoverRouter.name, path: '', initialChildren: children);

  static const String name = 'DiscoverRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class SearchRouter extends _i5.PageRouteInfo<void> {
  const SearchRouter({List<_i5.PageRouteInfo>? children})
      : super(SearchRouter.name, path: 'search', initialChildren: children);

  static const String name = 'SearchRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class ListsRouter extends _i5.PageRouteInfo<void> {
  const ListsRouter({List<_i5.PageRouteInfo>? children})
      : super(ListsRouter.name, path: 'lists', initialChildren: children);

  static const String name = 'ListsRouter';
}

/// generated route for
/// [_i5.EmptyRouterPage]
class SettingsRouter extends _i5.PageRouteInfo<void> {
  const SettingsRouter({List<_i5.PageRouteInfo>? children})
      : super(SettingsRouter.name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i6.DiscoverPage]
class DiscoverRoute extends _i5.PageRouteInfo<void> {
  const DiscoverRoute() : super(DiscoverRoute.name, path: '');

  static const String name = 'DiscoverRoute';
}

/// generated route for
/// [_i7.SinglePodcastPage]
class SinglePodcastRoute extends _i5.PageRouteInfo<SinglePodcastRouteArgs> {
  SinglePodcastRoute({_i11.Key? key, _i12.Podcast? podcast, int? podcastId})
      : super(SinglePodcastRoute.name,
            path: ':podcastId',
            args: SinglePodcastRouteArgs(
                key: key, podcast: podcast, podcastId: podcastId),
            rawPathParams: {'podcastId': podcastId});

  static const String name = 'SinglePodcastRoute';
}

class SinglePodcastRouteArgs {
  const SinglePodcastRouteArgs({this.key, this.podcast, this.podcastId});

  final _i11.Key? key;

  final _i12.Podcast? podcast;

  final int? podcastId;

  @override
  String toString() {
    return 'SinglePodcastRouteArgs{key: $key, podcast: $podcast, podcastId: $podcastId}';
  }
}

/// generated route for
/// [_i8.SearchPage]
class SearchRoute extends _i5.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i9.ListsPage]
class ListsRoute extends _i5.PageRouteInfo<void> {
  const ListsRoute() : super(ListsRoute.name, path: '');

  static const String name = 'ListsRoute';
}

/// generated route for
/// [_i10.SettingsPage]
class SettingsRoute extends _i5.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '');

  static const String name = 'SettingsRoute';
}
