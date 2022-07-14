import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/providers/language_provider.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/auth/auth_callout.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';
import 'package:podfetch_flutter/widgets/settings/settings_tile.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';
import '../widgets/base/page_wrap.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final language = ref.watch(languageProvider);
    return PageWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Heading(
            'Settings',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kPagePadding),
                child: AuthCallout(),
              ),
              const SizedBox(
                height: 16.0,
              ),
              if (auth.isLoggedIn)
                SettingsTile(
                  leading: const Icon(BootstrapIcons.person),
                  title: const Text('Account'),
                  onTap: () => context.router.push(const AccountRoute()),
                ),
              SettingsTile(
                leading: const Icon(BootstrapIcons.download),
                title: const Text('Storage'),
                onTap: () => context.router.push(const StorageRoute()),
              ),
              SettingsTile(
                leading: const Icon(BootstrapIcons.translate),
                title: const Text('Language'),
                trailing: Text(language.name),
                onTap: () => context.router.push(const LanguageSelectRoute()),
              ),
              // if (auth.isLoggedIn) const AuthInfo(),
            ],
          )
        ],
      ),
    );
  }
}
