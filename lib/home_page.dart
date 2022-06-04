import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/base/app_bar.dart';
import 'package:podfetch_flutter/widgets/base/bottom_navigation_bar.dart';
import 'package:podfetch_flutter/widgets/notifications/notification_bar.dart';
import 'package:podfetch_flutter/widgets/player/play_button.dart';
import 'package:we_slide/we_slide.dart';

import 'routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.router.canPopSelfOrChildren) {
          return context.router.pop(true);
        }
        return false;
      },
      child: AutoTabsScaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        navigatorObservers: () => [HeroController()],
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
            appBarHeight: MediaQuery.of(context).padding.top + kToolbarHeight,
            footerHeight: footerHeight,
            backgroundColor: Theme.of(context).backgroundColor,
            controller: controller,
            body: Stack(
              children: [
                child,
                SizedBox(
                  height: appBarHeight,
                  child: PfAppBar(
                    tabsRouter: tabsRouter,
                  ),
                ),
              ],
            ),
            panel: Container(
              color: theme.primaryColorLight,
              child: const Center(child: Text("This is the panel 😊")),
            ),
            panelHeader: GestureDetector(
              onTap: () {
                // controller.show();
                const NotificationBar(
                  message: 'test',
                ).show(context);
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
          /* return Stack(
            children: [
              child,
              const PfPlayerBase(),
            ],
          ); */
        },
        /* bottomNavigationBuilder: (_, tabsRouter) {
          return PfBottomNavigationBar(tabsRouter: tabsRouter);
        }, */
      ),
    );
  }
}
