import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/pages/to_implement.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';

import '../widgets/base/page_wrap.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const ToImplement(title: 'Discover');
    return PageWrap(
      child: Column(
        children: [
          Text('Discover...'),
          ElevatedButton(
            onPressed: () {
              context.navigateTo(SinglePodcastRoute());
            },
            child: const Text('To Podcast'),
          )
        ],
      ),
    );
  }
}
