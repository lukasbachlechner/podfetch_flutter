import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/providers/page_title_provider.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/base/app_bar.dart';
import 'package:podfetch_flutter/widgets/base/bottom_navigation_bar.dart';
import 'package:podfetch_flutter/widgets/notifications/notification_bar.dart';
import 'package:podfetch_flutter/widgets/player/play_button.dart';
import 'package:we_slide/we_slide.dart';

import 'routes/router.gr.dart';

class PageTitleObserver extends AutoRouterObserver {
  // final StateController<String> pageTitleProviderState;
  final WidgetRef ref;
  PageTitleObserver(this.ref) : super();

  @override
  void didPop(route, previousRoute) {
    ref.read(pageTitleProvider.notifier).reset();
  }

  @override
  void didPush(route, previousRoute) {
    print(route);
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.isLoggedIn == false) {
        print('is not logged in anymore');
      }
    });

    // final pageTitleProviderState = ref.read(pageTitleProvider.notifier);

    final hasTitle = ref.watch(pageTitleProvider).isNotEmpty;

    return WillPopScope(
      onWillPop: () async {
        if (context.router.canPopSelfOrChildren) {
          return context.router.pop(true);
        }
        return false;
      },
      child: AutoTabsScaffold(
        resizeToAvoidBottomInset: false,
        navigatorObservers: () => [HeroController(), AutoRouteObserver()],
        routes: const [
          DiscoverRouter(),
          SearchRouter(),
          ListsRouter(),
          SettingsRouter(),
        ],
        // appBarBuilder: (_, tabsRouter) => PfAppBar(tabsRouter: tabsRouter),
        builder: (context, child, _) {
          final tabsRouter = context.tabsRouter;
          final theme = Theme.of(context);

          const showPlayer = true;

          final double appBarHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final showAppBar = hasTitle || context.router.canPopSelfOrChildren;

          const double footerHeight = 120.0;
          const double panelHeaderSize = 80.0;

          double panelMinSize = footerHeight + panelHeaderSize;
          double panelMaxSize = MediaQuery.of(context).size.height;

          final controller = WeSlideController();

          // ignore: dead_code
          if (!showPlayer) {
            panelMinSize = 0;
          }

          return WeSlide(
            parallax: true,
            hideAppBar: true,
            hideFooter: true,
            panelMinSize: panelMinSize,
            panelMaxSize: panelMaxSize,
            panelBorderRadiusBegin: 0.0,
            panelBorderRadiusEnd: 0.0,
            overlay: true,
            parallaxOffset: 0.1,
            appBarHeight: showAppBar ? appBarHeight : 0,
            appBar: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: showAppBar ? 1 : 0,
              child: PfAppBar(
                tabsRouter: tabsRouter,
              ),
            ),
            footerHeight: footerHeight,
            backgroundColor: Theme.of(context).backgroundColor,
            controller: controller,
            body: SafeArea(
              top: !showAppBar,
              bottom: false,
              child: child,
            ),
            panel: Container(
              color: theme.primaryColorLight,
              child: const Center(child: Text("This is the panel 😊")),
            ),
            panelHeader: GestureDetector(
              onTap: () {
                // controller.show();
              },
              child: Stack(
                children: [
                  Container(
                    height: panelHeaderSize,
                    color: theme.primaryColorLight,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kPagePadding),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: CachedNetworkImage(
                              width: 36.0,
                              height: 36.0,
                              imageUrl: 'https://picsum.photos/64',
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Episode',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Podcast',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    )),
                              ],
                            ),
                          ),
                          const Spacer(),
                          PlayButton(onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 2,
                    color: theme.highlightColor,
                  )
                ],
              ),
            ),
            footer: PfBottomNavigationBar(
              tabsRouter: tabsRouter,
            ),
          );
        },
      ),
    );
  }
}
