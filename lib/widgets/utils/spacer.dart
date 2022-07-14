import 'package:flutter/material.dart';

enum SpacerLocation { top, bottom }

class PfSpacer extends StatelessWidget {
  const PfSpacer({Key? key, this.location = SpacerLocation.top})
      : super(key: key);
  final SpacerLocation location;

  const PfSpacer.top({Key? key})
      : location = SpacerLocation.top,
        super(key: key);

  const PfSpacer.bottom({Key? key})
      : location = SpacerLocation.bottom,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getHeight(context),
    );
  }

  double _getHeight(BuildContext context) {
    if (location == SpacerLocation.bottom) {
      return 80.0;
    }

    return MediaQuery.of(context).padding.top + kToolbarHeight;
  }
}
