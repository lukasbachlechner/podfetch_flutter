import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final WidgetRef _ref;

  AuthGuard(this._ref);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_ref.watch(authProvider.notifier).isLoggedIn) {
      resolver.next(true);
    } else {
      router.push(
        LoginRoute(
          onLogin: () {
            resolver.next();
            router.removeLast();
          },
        ),
      );
    }
  }
}
