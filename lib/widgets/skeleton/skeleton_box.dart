import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SkeletonBox extends HookWidget {
  const SkeletonBox({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = 4.0,
    this.textStyle,
    this.text,
    this.shape = BoxShape.rectangle,
    this.maxLines,
  })  : _onLight = false,
        super(key: key);

  const SkeletonBox.light({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = 40.0,
    this.textStyle,
    this.text,
    this.shape = BoxShape.rectangle,
    this.maxLines,
  })  : _onLight = true,
        super(key: key);

  final double? width;
  final double? height;
  final double borderRadius;
  final TextStyle? textStyle;
  final String? text;
  final BoxShape shape;
  final int? maxLines;

  final bool _onLight;

  @override
  Widget build(BuildContext context) {
    double? usedHeight = height;
    final color = _onLight
        ? Colors.white.withOpacity(0.2)
        : Theme.of(context).primaryColorLight;

    final textStyleToUse = textStyle ?? Theme.of(context).textTheme.bodySmall!;

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1500),
      lowerBound: 0.4,
      upperBound: 1.0,
    );

    animationController.repeat(reverse: true);

    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Opacity(
            opacity: animationController.value,
            child: text != null
                ? Text(
                    text!,
                    maxLines: maxLines,
                    strutStyle: StrutStyle(
                      leading: 0.6,
                      fontSize: textStyleToUse.fontSize,
                      fontFamily: textStyleToUse.fontFamily,
                      fontStyle: textStyleToUse.fontStyle,
                    ),
                    style: textStyleToUse.copyWith(
                      backgroundColor: color,
                      color: Colors.transparent,
                    ),
                  )
                : Container(
                    width: width,
                    height: usedHeight,
                    decoration: BoxDecoration(
                      shape: shape,
                      borderRadius: shape == BoxShape.rectangle
                          ? BorderRadius.circular(borderRadius)
                          : null,
                      color: color,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
