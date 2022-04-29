import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:podfetch_flutter/widgets/base/app_bar.dart';
import 'package:podfetch_flutter/widgets/base/bottom_navigation_bar.dart';
import 'package:podfetch_flutter/widgets/player/podcast_player.dart';
import 'pages/search_page.dart';
import 'widgets/buttons/icon_button.dart';
import 'delegates/search/search_delegate.dart';

import 'routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      extendBodyBehindAppBar: true,
      navigatorObservers: () => [HeroController()],
      routes: const [
        DiscoverRouter(),
        SearchRouter(),
        ListsRouter(),
        SettingsRouter(),
      ],
      // appBarBuilder: (_, __) => const PfAppBar(),
      /* builder: (context, child, _) {
        var appBarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
        return Stack(
          children: [
            child,
            SizedBox(
              height: appBarHeight,
              child: 
            ),
            // const PfPlayerBase(),
          ],
        );
      }, */
      bottomNavigationBuilder: (_, tabsRouter) {
        return PfBottomNavigationBar(tabsRouter: tabsRouter);
      },
    );
  }
}
