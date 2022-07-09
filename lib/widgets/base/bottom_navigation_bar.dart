import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';

class PfBottomNavigationBar extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
            icon: BootstrapIcons.search,
            activeIcon: BootstrapIcons.search,
            label: 'Search',
          ),
          if (ref.watch(authProvider).isLoggedIn)
            _buildItem(
              context: context,
              icon: BootstrapIcons.view_list,
              activeIcon: BootstrapIcons.view_list,
              label: 'Lists',
            ),
          _buildItem(
            context: context,
            icon: BootstrapIcons.gear,
            activeIcon: BootstrapIcons.gear_fill,
            label: 'Settings',
          ),
        ],
        onTap: (int newIndex) {
          if (tabsRouter.activeIndex != newIndex) {
            tabsRouter.setActiveIndex(newIndex);
          } else {
            tabsRouter.stackRouterOfIndex(newIndex)?.popUntilRoot();
            // tabsRouter.popTop();
          }
        },
        currentIndex: tabsRouter.activeIndex,
      ),
    );
  }
}
