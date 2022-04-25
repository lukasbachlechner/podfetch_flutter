import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/pages/search_page.dart';
import 'package:podfetch_flutter/widgets/buttons/icon_button.dart';

import 'routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (_, tabsRouter) => AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leadingWidth: 80.0,
        elevation: 0.0,
        leading: context.watchRouter.canPopSelfOrChildren
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: const [
                      Icon(
                        BootstrapIcons.arrow_left,
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text('Back'),
                    ],
                  ),
                ),
                onTap: () => context.router.popTop(),
              )
            : null,
        actions: [
          PfIconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: PfSearchDelegate(),
              );
            },
            icon: const Icon(
              BootstrapIcons.search,
              size: 20.0,
            ),
          )
        ],
      ),
      routes: const [
        DiscoverRouter(),
        SearchRouter(),
        CategoriesRouter(),
        DownloadsRouter(),
        SettingsRouter(),
      ],
      /*  builder: (_, Widget child, __) {
        return child;
      }, */
      bottomNavigationBuilder: (_, tabsRouter) {
        return PfBottomNavigationBar(tabsRouter: tabsRouter);
      },
    );
  }
}

class PfBottomNavigationBar extends StatelessWidget {
  const PfBottomNavigationBar({
    Key? key,
    required this.tabsRouter,
  }) : super(key: key);

  final TabsRouter tabsRouter;

  BottomNavigationBarItem _buildItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(12.0),
        color: Colors.transparent,
        child: Icon(icon),
      ),
      activeIcon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Theme.of(context).primaryColorLight,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Icon(activeIcon),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildItem(
            context: context,
            icon: BootstrapIcons.house,
            activeIcon: BootstrapIcons.house_fill,
            label: 'Discover',
          ),
          _buildItem(
            context: context,
            icon: BootstrapIcons.heart,
            activeIcon: BootstrapIcons.heart_fill,
            label: 'Liked',
          ),
          _buildItem(
            context: context,
            icon: BootstrapIcons.grid,
            activeIcon: BootstrapIcons.grid_fill,
            label: 'Categories',
          ),
          _buildItem(
            context: context,
            icon: BootstrapIcons.download,
            activeIcon: BootstrapIcons.download,
            label: 'Downloads',
          ),
          /* _buildItem(
            context: context,
            icon: BootstrapIcons.search,
            activeIcon: BootstrapIcons.search,
            label: 'Search',
          ), */
          _buildItem(
            context: context,
            icon: BootstrapIcons.gear,
            activeIcon: BootstrapIcons.gear_fill,
            label: 'Settings',
          ),
        ],
        onTap: tabsRouter.setActiveIndex,
        currentIndex: tabsRouter.activeIndex,
      ),
    );
    ;
  }
}

class PfSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Visibility(
        visible: query.isNotEmpty,
        child: PfIconButton(
          icon: const Icon(
            Icons.clear,
            size: 20.0,
          ),
          onPressed: () {
            query = '';
          },
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return PfIconButton(
      icon: const Icon(BootstrapIcons.arrow_left),
      onPressed: () {
        context.router.popTop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Suggestion $index'),
          onTap: () {
            query = 'Suggestion $index';
          },
        );
      },
      itemCount: 10,
    );
  }
}
