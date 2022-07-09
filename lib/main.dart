import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/routes/guards/auth_guard.dart';
import 'package:podfetch_flutter/service_locator.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'routes/router.gr.dart';
import 'theme.dart';

void main() async {
  /* setupLocators();
  Socket socket = io(
    'http://localhost:3333',
    OptionBuilder()
        .setAuth({
          'token':
              'Y2wzeWM5MXY0MDAwMWV0b2E5OWsxYTNzcw.nsJ2NkogD1xoj3F5JjDrOOoXQexcAUmm9jIyVDFDd90NxNCYqzfqJQw3hYi7'
        })
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build(),
  );

  socket.on('connect', (_) {
    print('connect');
  });
  socket.on('event', (data) => print(data));
  socket.on('disconnect', (_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));

  socket.connect(); */

  await Hive.initFlutter();
  await Hive.openBox('localSettings');

  runApp(
    ProviderScope(
      child: AppWidget(),
    ),
  );
}

class AppWidget extends HookConsumerWidget {
  AppWidget({Key? key}) : super(key: key);
  // final appRouter = AppRouter(authGuard: AuthGuard());
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // useMemoized((() => appRouter.authGuard.auth = ref.watch(authProvider)));

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Podfetch',
        /*  routerDelegate: AutoRouterDelegate.declarative(
          appRouter,
          routes: (_) => [
            if (isLoggedIn)
              const HomeRouter()
            else
              LoginRoute(
                onLogin: () {},
              )
          ],
        ), */
        routerDelegate: appRouter.delegate(),
        theme: pfDefaultTheme,
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
