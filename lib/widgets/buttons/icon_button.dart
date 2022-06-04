import 'package:flutter/material.dart';

class PfIconButton extends StatelessWidget {
  const PfIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.color,
    this.padding = const EdgeInsets.all(8.0),
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
  }) : super(key: key);
  final void Function() onPressed;
  final Widget icon;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final double maxHeight;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      onPressed: onPressed,
      padding: padding,
      icon: icon,
      color: color,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
