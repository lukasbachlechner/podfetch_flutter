import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:countries_utils/countries_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/language_provider.dart';
import 'package:podfetch_flutter/services/language_service.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';

import '../theme.dart';
import '../widgets/typography/heading.dart';
import '../widgets/utils/spacer.dart';

class LanguageSelectPage extends HookConsumerWidget {
  const LanguageSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTerm = useState<String>('');
    final currentLanguage =
        useState<String>(ref.watch(languageProvider).isoCode);
    final languages = LanguageService.all()
        .where(
          (language) => language.name.toLowerCase().contains(
                searchTerm.value.toLowerCase(),
              ),
        )
        .toList();

    final searchFieldController = useTextEditingController();

    return PageWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PfSpacer.top(),
          const Heading(
            'Set language',
            headingType: HeadingType.h2,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kPagePadding),
            child: Text(
                'This is the default language that you prefer to listen podcasts to.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPagePadding,
              vertical: 16.0,
            ),
            child: TextField(
              controller: searchFieldController,
              decoration: InputDecoration(
                label: const Text('Search'),
                prefixIcon: const Icon(BootstrapIcons.search),
                suffixIcon: searchTerm.value.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          searchTerm.value = '';
                          searchFieldController.text = '';
                        },
                        child: const Icon(
                          BootstrapIcons.x,
                        ),
                      )
                    : null,
              ),
              textInputAction: TextInputAction.search,
              onChanged: (query) => searchTerm.value = query,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final language = languages[index];
                return RadioListTile(
                  value: language.isoCode,
                  groupValue: currentLanguage.value,
                  onChanged: (value) {
                    ref.read(languageProvider.notifier).setLanguage(value);
                    currentLanguage.value = value as String;
                  },
                  title: Text(language.name),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 2.0),
              itemCount: languages.length,
            ),
          ),
        ],
      ),
    );
  }
}
