import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../buttons/icon_button.dart';

class PfAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PfAppBar({
    Key? key,
    this.title,
    this.actions,
    required this.tabsRouter,
  }) : super(key: key);

  final String? title;
  final List<Widget>? actions;
  final TabsRouter tabsRouter;

  @override
  PreferredSizeWidget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent, // Theme.of(context).primaryColor,
      elevation: 0.0,
      leading: tabsRouter.canPopSelfOrChildren
          ? PfIconButton(
              onPressed: () => context.router.popTop(),
              icon: const Icon(BootstrapIcons.arrow_left),
            )
          : null,
      actions: [...?actions],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PfAppBarCircleButton extends StatelessWidget {
  const PfAppBarCircleButton({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  final void Function() onTap;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              color: Theme.of(context).primaryColorLight.withOpacity(0.9),
              width: 48.0,
              height: 48.0,
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
