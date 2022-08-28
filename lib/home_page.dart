import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers.dart';
import 'package:podfetch_flutter/widgets/player/podcast_full_player.dart';
import 'package:podfetch_flutter/widgets/player/podcast_mini_player.dart';
import 'providers/auth_provider.dart';
import 'widgets/base/app_bar.dart';
import 'widgets/base/bottom_navigation_bar.dart';
import 'package:we_slide/we_slide.dart';

import 'routes/router.gr.dart';

class PageTitleObserver extends AutoRouterObserver {
  // final StateController<String> pageTitleProviderState;
  final WidgetRef ref;
  PageTitleObserver(this.ref) : super();

  @override
  void didPop(route, previousRoute) {}

  @override
  void didPush(route, previousRoute) {
    print(route);
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final pageTitleProviderState = ref.read(pageTitleProvider.notifier);

    return WillPopScope(
      onWillPop: () async {
        if (context.router.canPopSelfOrChildren) {
          return context.router.pop(true);
        }
        return false;
      },
      child: ScaffoldMessenger(
        key: ref.watch(snackbarProvider).key,
        child: AutoTabsScaffold(
          resizeToAvoidBottomInset: false,
          navigatorObservers: () => [HeroController(), AutoRouteObserver()],
          routes: const [
            PersonalRouter(),
            DiscoverRouter(),
            ListsRouter(),
            SettingsRouter(),
          ],
          // appBarBuilder: (_, tabsRouter) => PfAppBar(tabsRouter: tabsRouter),
          builder: (context, child, _) {
            final tabsRouter = context.tabsRouter;
            final theme = Theme.of(context);

            final showPlayer =
                ref.watch(audioPlayerProvider).currentEpisode != null;

            final double appBarHeight =
                kToolbarHeight + MediaQuery.of(context).padding.top;
            final showAppBar = context.router.canPopSelfOrChildren;

            const double footerHeight = 120.0;
            const double panelHeaderSize = 80.0;

            double panelMinSize = footerHeight + panelHeaderSize;
            double panelMaxSize = MediaQuery.of(context).size.height;

            // final controller = ref.watch(weSlideControllerProvider);

            final controller = WeSlideController();

            if (!showPlayer) {
              panelMinSize = 0;
            }

            return WeSlide(
              parallax: false,
              hideAppBar: true,
              hideFooter: true,
              panelMinSize: panelMinSize,
              panelMaxSize: panelMaxSize,
              panelBorderRadiusBegin: 0.0,
              panelBorderRadiusEnd: 0.0,
              overlay: true,
              parallaxOffset: 0.1,
              appBarHeight: showAppBar ? appBarHeight : 0,
              /*  appBar: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: showAppBar ? 1 : 0,
                child: PfAppBar(
                  tabsRouter: tabsRouter,
                ),
              ), */
              footerHeight: footerHeight,
              backgroundColor: Theme.of(context).backgroundColor,
              controller: controller,
              body: SafeArea(
                top: !showAppBar,
                bottom: false,
                child: child,
              ),
              panel: PodcastFullPlayer(
                weSlideController: controller,
              ),
              panelHeader: GestureDetector(
                onTap: () {
                  // controller.show();
                },
                child: PodcastMiniPlayer(
                  height: panelHeaderSize,
                  weSlideController: controller,
                ),
              ),
              footer: PfBottomNavigationBar(
                tabsRouter: tabsRouter,
              ),
            );
          },
        ),
      ),
    );
  }
}
