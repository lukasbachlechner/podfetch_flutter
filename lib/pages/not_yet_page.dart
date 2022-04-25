import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';

class NotYetPage extends StatelessWidget {
  const NotYetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrap(
        child: Center(
      child: Column(
        children: [
          Text(
            context.router.routeData.path.toUpperCase().toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
          const Text('Implement me :)'),
        ],
      ),
    ));
  }
}
