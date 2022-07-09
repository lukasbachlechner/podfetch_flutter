import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';
import 'package:podfetch_flutter/widgets/settings/settings_tile.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';

import '../providers/auth_provider.dart';
import '../utils.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);
    if (!auth.isLoggedIn) {
      return const SizedBox.shrink();
    }
    return PageWrap(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 64.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    child: const Icon(
                      BootstrapIcons.person,
                      size: 48.0,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Heading(
                    auth.user!.email,
                    headingType: HeadingType.h3,
                    textAlign: TextAlign.center,
                  ),
                  Text('Member since ${formatDate(auth.user!.createdAt)}'),
                ],
              ),
            ),
          ),
          SettingsTile(
            title: const Text('Logout'),
            trailing: const Icon(BootstrapIcons.box_arrow_right),
            onTap: () => authNotifier.logout(),
          ),
        ],
      ),
    );
  }
}
