import 'package:auto_route/auto_route.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/services/url_service.dart';
import '../providers.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../routes/router.gr.dart';
import '../theme.dart';
import '../widgets/auth/auth_callout.dart';
import '../widgets/page/page_header.dart';
import '../widgets/settings/settings_tile.dart';
import '../widgets/typography/heading.dart';
import '../widgets/base/page_wrap.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final language = ref.watch(languageProvider);
    return PageWrap(
      children: [
        const Heading(
          'Settings',
        ),
        const SizedBox(height: 24),
        const Heading(
          'App',
          headingType: HeadingType.h3,
        ),
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
        const SizedBox(height: 24),
        const Heading(
          'Legal',
          headingType: HeadingType.h3,
        ),
        SettingsTile(
          title: const Text('Licenses'),
          onTap: () => showLicensePage(context: context),
        ),
        SettingsTile(
          title: const Text('Imprint & Privacy Policy'),
          onTap: () => UrlService.launch('https://podfetch.app/legal'),
        ),
        const SizedBox(height: 24),
        const Text(
          '© 2022, Lukas Bachlechner',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white24),
        )

        // if (auth.isLoggedIn) const AuthInfo(),
      ],
    );
  }
}
