import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/base/page_wrap.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';
import 'package:podfetch_flutter/widgets/settings/settings_tile.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';
import 'package:podfetch_flutter/widgets/utils/spacer.dart';

import '../providers/auth_provider.dart';
import '../utils.dart';

class StoragePage extends ConsumerWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /* final auth = ref.watch(authProvider);
    final authNotifier = ref.watch(authProvider.notifier);
    if (!auth.isLoggedIn) {
      return const SizedBox.shrink();
    } */
    return PageWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PfSpacer.top(),
          const Heading(
            'Cache',
            headingType: HeadingType.h2,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: kPagePadding),
            child: Text(
                'The total size of all cached files, e. g. network images.'),
          ),
        ],
      ),
    );
  }
}
