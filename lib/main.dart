import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';
import 'providers.dart';
import 'providers/auth_provider.dart';
import 'providers/snackbar_provider.dart';

import 'routes/router.gr.dart';
import 'theme.dart';

void main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.lukasbachlechner.podfetch.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    fastForwardInterval: const Duration(seconds: 15),
    rewindInterval: const Duration(seconds: 15),
  );

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
        routerDelegate: AutoRouterDelegate.declarative(
          appRouter,
          routes: (_) => [
            if (ref.watch(authProvider).isLoggedIn)
              const HomeRouter()
            else
              LoginRoute(
                onLogin: () {
                  return Future.value(null);
                },
              )
          ],
        ),
        // routerDelegate: appRouter.delegate(),
        theme: pfDefaultTheme,
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
