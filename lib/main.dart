import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/pages/splash_page.dart';
import 'package:podfetch_flutter/service_locator.dart';

import 'routes/router.gr.dart';
import 'theme.dart';

void main() {
  setupLocators();
  runApp(
    ProviderScope(
      child: AppWidget(),
    ),
  );
}

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Podfetch',
      routerDelegate: _appRouter.delegate(),
      theme: pfDefaultTheme,
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
