import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key? key,
    this.leading,
    this.title,
    this.trailing,
    this.trailingIcon,
    this.onTap,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final Widget? trailingIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: leading,
          title: title,
          tileColor: Theme.of(context).primaryColorLight,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              trailing ?? const SizedBox.shrink(),
              const SizedBox(width: 8.0),
              trailingIcon ?? const Icon(BootstrapIcons.arrow_right),
            ],
          ), // trailing ?? const Icon(BootstrapIcons.arrow_right),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
