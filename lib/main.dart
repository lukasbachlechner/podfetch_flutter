import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/routes/guards/auth_guard.dart';
import 'package:podfetch_flutter/service_locator.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'routes/router.gr.dart';
import 'theme.dart';

void main() {
  setupLocators();
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

  socket.connect();

  runApp(
    const ProviderScope(
      child: AppWidget(),
    ),
  );
}

class AppWidget extends ConsumerWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = AppRouter(authGuard: AuthGuard(ref));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Podfetch',
      /*  routerDelegate: AutoRouterDelegate.declarative(_appRouter,
          routes: (_) => [
                if (isLoggedIn.value)
                  const HomeRouter()
                else
                  LoginRoute(
                    onLogin: () => isLoggedIn.value = true,
                  )
              ]), */
      routerDelegate: appRouter.delegate(),
      theme: pfDefaultTheme,
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
