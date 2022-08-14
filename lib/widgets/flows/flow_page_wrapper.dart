import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '../../theme.dart';
import '../buttons/icon_button.dart';
import '../page/page_header.dart';
import '../utils/spacer.dart';

class FlowPageWrapper extends StatelessWidget {
  const FlowPageWrapper(
      {Key? key, required this.title, required this.children, this.bottomSheet})
      : super(key: key);

  final String title;
  final List<Widget> children;
  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: (context.router.canPopSelfOrChildren)
                ? PfIconButton(
                    onPressed: () => context.router.pop(),
                    icon: const Icon(BootstrapIcons.chevron_left))
                : null,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          bottomSheet: bottomSheet != null
              ? Container(
                  color: theme.backgroundColor,
                  padding: const EdgeInsets.all(
                    kPagePadding,
                  ),
                  child: bottomSheet,
                )
              : null,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PfPageHeader(
                      title: title,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kPagePadding),
                        child: Column(
                          children: children,
                        ),
                      ),
                    ),
                    const PfSpacer.bottom()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
