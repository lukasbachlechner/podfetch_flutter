import 'package:flutter/material.dart';
import '../../theme.dart';
import '../typography/heading.dart';

class PfPageHeader extends StatelessWidget {
  const PfPageHeader({Key? key, this.title, this.actions}) : super(key: key);
  final String? title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 64.0, left: kPagePadding, right: kPagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Heading(
            title ?? '',
            inPageContainer: false,
          ),
          Row(
            children: [if (actions != null) ...actions!],
          ),
        ],
      ),
    );
  }
}
