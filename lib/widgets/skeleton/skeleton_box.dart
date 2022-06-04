import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonBox extends StatelessWidget {
  const SkeletonBox(
      {Key? key,
      this.width,
      this.height,
      this.borderRadius = 4.0,
      this.textStyle})
      : super(key: key);
  final double? width;
  final double? height;
  final double borderRadius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    double? usedHeight = height;
    if (textStyle != null) {
      usedHeight = _calculateTextSize().height;
    }
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColorLight,
      child: Container(
        width: width,
        height: usedHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Size _calculateTextSize({String text = 'No Agenda'}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
