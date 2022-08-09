import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../skeleton/skeleton_box.dart';

class PfImage extends StatelessWidget {
  const PfImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.progressIndicatorBuilder,
  }) : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Widget Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder;

  Widget buildErrorWidget(BuildContext context, String error, _) {
    return const Center(
      child: Icon(Icons.warning),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorWidget: errorWidget ?? buildErrorWidget,
      /*  progressIndicatorBuilder: (context, url, progress) {
        if (progressIndicatorBuilder != null) {
          return progressIndicatorBuilder!(context, url, progress);
        }

        return Container(
          color: Colors.yellow,
        );
      }, */
      placeholder: (_, __) {
        return SkeletonBox(
          width: width,
          height: height,
        );
      },
    );
  }
}
