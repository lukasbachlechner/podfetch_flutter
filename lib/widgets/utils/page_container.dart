import 'package:flutter/material.dart';
import 'package:podfetch_flutter/theme.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    Key? key,
    this.child,
    this.bottom,
  }) : super(key: key);

  final Widget? child;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: kPagePadding,
        right: kPagePadding,
        bottom: bottom ?? 0,
      ),
      child: child,
    );
  }
}
