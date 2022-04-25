import 'package:flutter/material.dart';

class PfIconButton extends StatelessWidget {
  const PfIconButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);
  final void Function() onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
