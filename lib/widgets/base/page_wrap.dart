import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/widgets/base/app_bar.dart';
import '../../providers.dart';
import '../../providers/page_title_provider.dart';

/* class PageWrap extends HookConsumerWidget {
  const PageWrap({
    Key? key,
    this.title,
    required this.child,
  })  : _refreshable = false,
        onRefresh = null,
        super(key: key);

  const PageWrap.refreshable({
    Key? key,
    required this.child,
    this.onRefresh,
    this.title,
  })  : _refreshable = true,
        super(key: key);

  final bool _refreshable;
  final cupertino.RefreshCallback? onRefresh;
  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      print('set title to $title');
      ref.read(pageTitleProvider.notifier).set(title ?? '');
    });
 */
    if (_refreshable) {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: CustomScrollView(
          slivers: [
            cupertino.CupertinoSliverRefreshControl(
              onRefresh: onRefresh,
            ),
            SliverToBoxAdapter(
              child: child,
            )
          ],
        ),
      );
    }
    return Container(color: Theme.of(context).backgroundColor, child: child);
  }
} */

class PageWrap extends ConsumerStatefulWidget {
  const PageWrap({
    Key? key,
    this.title,
    this.useSlivers = false,
    this.children,
  })  : _refreshable = false,
        onRefresh = null,
        super(key: key);

  const PageWrap.refreshable({
    Key? key,
    required this.children,
    this.onRefresh,
    this.title,
  })  : _refreshable = true,
        useSlivers = true,
        super(key: key);

  final bool _refreshable;
  final bool useSlivers;
  final cupertino.RefreshCallback? onRefresh;
  final String? title;
  final List<Widget>? children;

  @override
  ConsumerState<PageWrap> createState() => _PageWrapState();
}

class _PageWrapState extends ConsumerState<PageWrap>
    with AutoRouteAwareStateMixin {
  @override
  void didPush() {
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.title != null) {
        ref.read(pageTitleProvider.notifier).set(widget.title!);
      }
    }); */

    super.didPush();
  }

  @override
  void didPopNext() {
    /* WidgetsBinding.instance.addPostFrameCallback((_) {});
    if (widget.title != null) {
      ref.read(pageTitleProvider.notifier).set(widget.title!);
    } else {
      ref.read(pageTitleProvider.notifier).reset();
    } */
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Scrollbar(
        child: CustomScrollView(
          physics: const cupertino.BouncingScrollPhysics(),
          slivers: [
            if (widget.title != null)
              SliverPfAppBar(
                title: widget.title!,
              ),
            if (widget.onRefresh != null)
              cupertino.CupertinoSliverRefreshControl(
                onRefresh: widget.onRefresh,
              ),
            ...?widget.children?.map(
              (child) {
                if (child.runtimeType.toString().startsWith('Sliver')) {
                  return child;
                }
                return SliverToBoxAdapter(
                  child: child,
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
