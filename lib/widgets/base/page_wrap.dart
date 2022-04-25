import 'package:flutter/material.dart';

class PageWrap extends StatelessWidget {
  const PageWrap({Key? key, required this.child, this.fixed}) : super(key: key);
  final Widget child;
  final Widget? fixed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          fixed != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: fixed,
                )
              : const SizedBox(),
          Expanded(
            child: SingleChildScrollView(child: child),
          ),
        ],
      ),
    );
  }
}
