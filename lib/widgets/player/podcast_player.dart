import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

class PfPlayerBase extends StatelessWidget {
  const PfPlayerBase({Key? key}) : super(key: key);
  static const minPlayerHeight = 48.0;
  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      minHeight: minPlayerHeight,
      elevation: 0,
      maxHeight: MediaQuery.of(context).size.height,
      builder: (height, percentage) {
        return Container(
          color: Theme.of(context).primaryColorLight,
          child: const Placeholder(),
        );
      },
    );
  }
}
