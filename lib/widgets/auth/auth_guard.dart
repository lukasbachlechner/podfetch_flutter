import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers.dart';
import '../../providers/auth_provider.dart';

class AuthGuard extends ConsumerWidget {
  const AuthGuard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    if (auth.isLoggedIn) {
      return child;
    }
    return const SizedBox.shrink();
  }
}
