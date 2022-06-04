import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageWrap extends ConsumerWidget {
  const PageWrap({
    Key? key,
    required this.child,
    this.showAppBar = true,
    this.title,
  }) : super(key: key);
  final Widget child;
  final bool showAppBar;
  final String? title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(color: Theme.of(context).backgroundColor, child: child);
  }
}
