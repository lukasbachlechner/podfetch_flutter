import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widgets/page/page_header.dart';
import '../widgets/base/page_wrap.dart';

class NotYetPage extends StatelessWidget {
  const NotYetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PfPageHeader(
            title: context.router.routeData.path.toUpperCase(),
          ),
          const Text('Implement me :)'),
        ],
      ),
    );
  }
}
