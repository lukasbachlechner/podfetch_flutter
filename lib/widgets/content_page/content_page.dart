import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_flutter/widgets/content_page/content_page_header.dart';
import 'package:podfetch_flutter/widgets/content_page/content_page_title_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../base/page_wrap.dart';
import '../utils/spacer.dart';

class ContentPage extends HookWidget {
  const ContentPage({
    Key? key,
    this.onRefresh,
    required this.header,
    required this.headerImageUrl,
    required this.body,
    this.titleBar,
    this.titleKey,
    this.title,
  }) : super(key: key);

  final Future<void> Function()? onRefresh;
  final List<Widget> header;
  final String headerImageUrl;
  final List<Widget> body;
  final List<Widget>? titleBar;
  final Key? titleKey;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final childWrap = SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          ContentPageHeader(
            imageUrl: headerImageUrl,
            children: header,
          ),
          ...body,
          const PfSpacer.bottom()
        ],
      ),
    );

    if (onRefresh != null) {
      return PageWrap.refreshable(
        onRefresh: onRefresh,
        title: title,
        children: [
          ContentPageHeader(
            imageUrl: headerImageUrl,
            children: header,
          ),
          ...body,
        ],
      );
    }
    return PageWrap(
      title: title,
      child: childWrap,
    );
  }
}
