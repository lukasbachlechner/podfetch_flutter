import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timer = Timer.periodic(const Duration(seconds: 2), (_) {
      context.router.root.replace(const HomeRouter());
    });
    return Container(
      color: Colors.red,
      child: const Center(
        child: FlutterLogo(),
      ),
    );
  }
}
