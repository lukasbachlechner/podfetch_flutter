import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ContentPageHeader extends StatelessWidget {
  const ContentPageHeader(
      {Key? key, required this.children, required this.imageUrl})
      : super(key: key);
  final List<Widget> children;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  imageUrl,
                  maxWidth: 5,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.0,
                  0.6,
                  0.9,
                ],
                colors: [
                  Theme.of(context).backgroundColor.withOpacity(0.25),
                  Theme.of(context).backgroundColor.withOpacity(0.75),
                  Theme.of(context).backgroundColor,
                ],
              ),
            ),
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
