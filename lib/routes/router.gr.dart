// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i7;

import '../home_page.dart' as _i1;
import '../pages/discover_page.dart' as _i5;
import '../pages/not_yet_page.dart' as _i6;
import '../pages/search_page.dart' as _i3;
import '../pages/single_podcast_page.dart' as _i4;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRouter.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    SearchRouter.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    DiscoverRouter.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    LikedRouter.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    CategoriesRouter.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    DownloadsRouter.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    SettingsRouter.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    SearchRoute.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i3.SearchPage());
    },
    SinglePodcastRoute.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i4.SinglePodcastPage());
    },
    DiscoverRoute.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.DiscoverPage());
    },
    NotYetRoute.name: (routeData) {
      return _i2.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.NotYetPage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRouter.name, path: '/', children: [
          _i2.RouteConfig(SearchRouter.name,
              path: 'search',
              parent: HomeRouter.name,
              children: [
                _i2.RouteConfig(SearchRoute.name,
                    path: '', parent: SearchRouter.name),
                _i2.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: SearchRouter.name)
              ]),
          _i2.RouteConfig(DiscoverRouter.name,
              path: 'podcasts',
              parent: HomeRouter.name,
              children: [
                _i2.RouteConfig(DiscoverRoute.name,
                    path: '', parent: DiscoverRouter.name),
                _i2.RouteConfig(SinglePodcastRoute.name,
                    path: ':podcastId', parent: DiscoverRouter.name)
              ]),
          _i2.RouteConfig(LikedRouter.name,
              path: 'liked',
              parent: HomeRouter.name,
              children: [
                _i2.RouteConfig(NotYetRoute.name,
                    path: '', parent: LikedRouter.name)
              ]),
          _i2.RouteConfig(CategoriesRouter.name,
              path: 'categories',
              parent: HomeRouter.name,
              children: [
                _i2.RouteConfig(NotYetRoute.name,
                    path: '', parent: CategoriesRouter.name)
              ]),
          _i2.RouteConfig(DownloadsRouter.name,
              path: 'downloads',
              parent: HomeRouter.name,
              children: [
                _i2.RouteConfig(NotYetRoute.name,
                    path: '', parent: DownloadsRouter.name)
              ]),
          _i2.RouteConfig(SettingsRouter.name,
              path: 'settings',
              parent: HomeRouter.name,
              children: [
                _i2.RouteConfig(NotYetRoute.name,
                    path: '', parent: SettingsRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRouter extends _i2.PageRouteInfo<void> {
  const HomeRouter({List<_i2.PageRouteInfo>? children})
      : super(HomeRouter.name, path: '/', initialChildren: children);

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class SearchRouter extends _i2.PageRouteInfo<void> {
  const SearchRouter({List<_i2.PageRouteInfo>? children})
      : super(SearchRouter.name, path: 'search', initialChildren: children);

  static const String name = 'SearchRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class DiscoverRouter extends _i2.PageRouteInfo<void> {
  const DiscoverRouter({List<_i2.PageRouteInfo>? children})
      : super(DiscoverRouter.name, path: 'podcasts', initialChildren: children);

  static const String name = 'DiscoverRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class LikedRouter extends _i2.PageRouteInfo<void> {
  const LikedRouter({List<_i2.PageRouteInfo>? children})
      : super(LikedRouter.name, path: 'liked', initialChildren: children);

  static const String name = 'LikedRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class CategoriesRouter extends _i2.PageRouteInfo<void> {
  const CategoriesRouter({List<_i2.PageRouteInfo>? children})
      : super(CategoriesRouter.name,
            path: 'categories', initialChildren: children);

  static const String name = 'CategoriesRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class DownloadsRouter extends _i2.PageRouteInfo<void> {
  const DownloadsRouter({List<_i2.PageRouteInfo>? children})
      : super(DownloadsRouter.name,
            path: 'downloads', initialChildren: children);

  static const String name = 'DownloadsRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class SettingsRouter extends _i2.PageRouteInfo<void> {
  const SettingsRouter({List<_i2.PageRouteInfo>? children})
      : super(SettingsRouter.name, path: 'settings', initialChildren: children);

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i3.SearchPage]
class SearchRoute extends _i2.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i4.SinglePodcastPage]
class SinglePodcastRoute extends _i2.PageRouteInfo<void> {
  const SinglePodcastRoute()
      : super(SinglePodcastRoute.name, path: ':podcastId');

  static const String name = 'SinglePodcastRoute';
}

/// generated route for
/// [_i5.DiscoverPage]
class DiscoverRoute extends _i2.PageRouteInfo<void> {
  const DiscoverRoute() : super(DiscoverRoute.name, path: '');

  static const String name = 'DiscoverRoute';
}

/// generated route for
/// [_i6.NotYetPage]
class NotYetRoute extends _i2.PageRouteInfo<void> {
  const NotYetRoute() : super(NotYetRoute.name, path: '');

  static const String name = 'NotYetRoute';
}
