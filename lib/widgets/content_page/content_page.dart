import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_flutter/widgets/content_page/content_page_header.dart';
import 'package:podfetch_flutter/widgets/content_page/content_page_title_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../base/page_wrap.dart';
import '../utils/spacer.dart';

class ContentPage extends HookWidget {
  const ContentPage(
      {Key? key,
      this.onRefresh,
      required this.header,
      required this.headerImageUrl,
      required this.body,
      required this.titleBar,
      required this.titleKey})
      : super(key: key);
  final Future<void> Function()? onRefresh;
  final List<Widget> header;
  final String headerImageUrl;
  final List<Widget> body;
  final List<Widget> titleBar;
  final Key titleKey;

  Widget _maybeWrapWithRefreshIndicator({required Widget child}) {
    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh!, child: child);
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );
    final appBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.ease));

    useEffect(() {
      return () => VisibilityDetectorController.instance.notifyNow();
    }, []);

    VisibilityDetectorController.instance.updateInterval =
        const Duration(milliseconds: 100);

    return PageWrap(
      child: _maybeWrapWithRefreshIndicator(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  VisibilityDetector(
                    key: titleKey,
                    child: ContentPageHeader(
                      imageUrl: headerImageUrl,
                      children: header,
                    ),
                    onVisibilityChanged: (visibilityInfo) {
                      if (visibilityInfo.visibleFraction < 0.25) {
                        animationController.forward();
                      } else {
                        animationController.reverse();
                      }
                    },
                  ),
                  ...body,
                  PfSpacer.bottom()
                ],
              ),
            ),
            ContentPageTitleBar(opacity: appBarAnimation, children: titleBar)
          ],
        ),
      ),
    );
  }
}
