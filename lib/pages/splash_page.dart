import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _timer = Timer.periodic(Duration(seconds: 2), (_) {
      context.router.root.replace(HomeRouter());
    });
    return Container(
      color: Colors.red,
      child: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
