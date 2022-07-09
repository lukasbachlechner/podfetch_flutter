import 'package:flutter/material.dart';
import 'package:podfetch_flutter/theme.dart';

enum HeadingType { h1, h2, h3 }

class Heading extends StatelessWidget {
  const Heading(this.title,
      {Key? key,
      this.headingType = HeadingType.h1,
      this.inPageContainer = true,
      this.paddingTop = 0.0,
      this.paddingBottom = 8.0,
      this.textAlign = TextAlign.left})
      : super(key: key);
  final String title;
  final HeadingType headingType;
  final bool inPageContainer;
  final double paddingTop;
  final double paddingBottom;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    final horizontalPadding = inPageContainer ? kPagePadding : 0.0;
    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: Text(
        title,
        textAlign: textAlign,
        style: _getTextStyleForLevel(context),
      ),
    );
  }

  TextStyle _getTextStyleForLevel(BuildContext context) {
    switch (headingType) {
      case HeadingType.h1:
        return Theme.of(context).textTheme.headline1!;
      case HeadingType.h2:
        return Theme.of(context).textTheme.headline2!;
      case HeadingType.h3:
        return Theme.of(context).textTheme.headline3!;
      default:
        return Theme.of(context).textTheme.headline1!;
    }
  }
}
