import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/hooks/use_memoized_future.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/buttons/button.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';
import '../widgets/base/page_wrap.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider.notifier);
    final auth = ref.watch(authProvider);
    return PageWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PfPageHeader(
            title: 'Settings',
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(auth.user?.email ?? ''),
                PfButton(
                  onPressed: () {
                    authNotifier.logout();
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
