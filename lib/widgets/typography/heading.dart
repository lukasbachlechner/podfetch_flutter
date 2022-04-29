import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/theme.dart';

enum HeadingType { h1, h2 }

class Heading extends StatelessWidget {
  const Heading(
    this.title, {
    Key? key,
    this.headingType = HeadingType.h1,
    this.inPageContainer = true,
    this.paddingTop = 0.0,
    this.paddingBottom = 0.0,
  }) : super(key: key);
  final String title;
  final HeadingType headingType;
  final bool inPageContainer;
  final double paddingTop;
  final double paddingBottom;
  @override
  Widget build(BuildContext context) {
    final _horizontalPadding = inPageContainer ? kPagePadding : 0.0;
    return Padding(
      padding: EdgeInsets.only(
        left: _horizontalPadding,
        right: _horizontalPadding,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: _getTextStyleForLevel(context),
          ),
        ],
      ),
    );
  }

  TextStyle _getTextStyleForLevel(BuildContext context) {
    switch (headingType) {
      case HeadingType.h1:
        return Theme.of(context).textTheme.headline1!;
      case HeadingType.h2:
        return Theme.of(context).textTheme.headline2!;
      default:
        return Theme.of(context).textTheme.headline1!;
    }
  }
}
