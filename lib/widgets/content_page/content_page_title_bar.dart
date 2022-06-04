import 'package:flutter/material.dart';

class ContentPageTitleBar extends StatelessWidget {
  const ContentPageTitleBar(
      {Key? key, required this.opacity, required this.children})
      : super(key: key);
  final Animation<double> opacity;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: SizedBox(
        height: kToolbarHeight + MediaQuery.of(context).padding.top,
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            children: [
              const SizedBox(
                width: 48.0,
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
