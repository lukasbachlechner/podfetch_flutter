import 'package:another_flushbar/flushbar.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../theme.dart';

enum NotificationBarType { success, warning, error, info }

class NotificationBarTypeStyle {
  final Color color;
  final IconData icon;
  final String? title;

  const NotificationBarTypeStyle(
      {required this.color, required this.icon, this.title});
}

class NotificationBar extends HookWidget {
  const NotificationBar(
      {Key? key,
      required this.message,
      this.title,
      this.icon,
      this.notificationType = NotificationBarType.info})
      : super(key: key);
  final String message;
  final String? title;
  final IconData? icon;
  final NotificationBarType notificationType;

  Flushbar _getWidget(BuildContext context) {
    final type = _getStyle(context);
    return Flushbar(
      borderRadius: BorderRadius.circular(4.0),
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor: Color.alphaBlend(
          type.color.withOpacity(0.2), Theme.of(context).backgroundColor),
      leftBarIndicatorColor: type.color,
      messageSize: 16.0,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CircleAvatar(
          backgroundColor: type.color,
          child: Icon(
            icon ?? type.icon,
            color: Colors.white,
          ),
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(kPagePadding),
      duration: const Duration(seconds: 2),
      title: title ?? type.title,
      message: message,
    );
  }

  Future<dynamic> show(BuildContext context) async {
    return _getWidget(context).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return _getWidget(context);
  }

  NotificationBarTypeStyle _getStyle(BuildContext context) {
    final types = <NotificationBarType, NotificationBarTypeStyle>{
      NotificationBarType.error: const NotificationBarTypeStyle(
        color: Colors.red,
        icon: BootstrapIcons.x,
        title: 'Error',
      ),
      NotificationBarType.warning: const NotificationBarTypeStyle(
        color: Colors.amber,
        icon: BootstrapIcons.exclamation,
        title: 'Warning',
      ),
      NotificationBarType.success: const NotificationBarTypeStyle(
        color: Colors.green,
        icon: BootstrapIcons.check,
        title: 'Success',
      ),
      NotificationBarType.info: NotificationBarTypeStyle(
        color: Theme.of(context).primaryColorLight,
        icon: BootstrapIcons.info,
        title: 'Info',
      )
    };

    return types[notificationType]!;
  }
}
