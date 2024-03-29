import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers.dart';
import '../../providers/auth_provider.dart';
import 'forms/login_form.dart';
import '../buttons/button.dart';
import '../modal/modal_wrapper.dart';

class AuthCallout extends ConsumerWidget {
  const AuthCallout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    if (auth.isLoggedIn) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You're missing out!",
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 16.0),
          const Text(
              "Create your account now to explore all functions of Podfetch, including offline storage, subscriptions, and much more!"),
          const SizedBox(height: 16.0),
          Row(
            children: [
              PfButton(
                onPressed: () {},
                buttonType: ButtonType.accent,
                child: const Text('Sign Up'),
              ),
              const SizedBox(width: 8.0),
              PfButton(
                onPressed: () {
                  showModalBottomSheet(
                      useRootNavigator: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return ModalWrapper(
                          title: 'Login',
                          children: [
                            LoginForm(onLogin: () async {
                              context.router.pop();
                            }),
                          ],
                        );
                      });
                },
                child: const Text('Login'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
