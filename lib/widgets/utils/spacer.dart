import 'package:flutter/material.dart';

enum SpacerLocation { top, bottom }

class PfSpacer extends StatelessWidget {
  const PfSpacer({Key? key, this.location = SpacerLocation.top})
      : super(key: key);
  final SpacerLocation location;

  factory PfSpacer.top() {
    return const PfSpacer(
      location: SpacerLocation.top,
    );
  }

  factory PfSpacer.bottom() {
    return const PfSpacer(
      location: SpacerLocation.bottom,
    );
  }

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
