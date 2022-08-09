import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers.dart';
import '../../providers/api_provider.dart';
import '../../widgets/typography/heading.dart';

import '../../widgets/base/page_wrap.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(apiProvider);
    final allCategories = ref.watch(categoriesProvider).getAll();

    final rowsNeeded = (allCategories.length / 3).ceil();

    return PageWrap(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Heading(
              'Categories',
              headingType: HeadingType.h1,
            ),
          ],
        ),
      ),
    );
  }
}
