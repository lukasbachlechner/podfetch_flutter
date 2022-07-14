import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../buttons/button.dart';

class AuthInfo extends ConsumerWidget {
  const AuthInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('You are currently logged in as ${auth.user?.email}'),
          const SizedBox(
            height: 8,
          ),
          PfButton(
            onPressed: () {
              authNotifier.logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
