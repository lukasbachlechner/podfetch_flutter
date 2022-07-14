import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/buttons/icon_button.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';
import 'package:podfetch_flutter/widgets/utils/spacer.dart';

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
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              PfIconButton(
                  onPressed: () => context.router.pop(),
                  icon: const Icon(BootstrapIcons.x))
            ],
          ),
          bottomSheet: Container(
            color: theme.backgroundColor,
            padding: const EdgeInsets.all(
              kPagePadding,
            ),
            child: bottomSheet,
          ),
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
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
