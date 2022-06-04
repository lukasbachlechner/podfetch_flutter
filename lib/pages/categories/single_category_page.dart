import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_flutter/service_locator.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';

import '../../widgets/base/page_wrap.dart';

class SingleCategoryPage extends StatelessWidget {
  const SingleCategoryPage(
      {Key? key, @PathParam('categoryId') required this.categoryId})
      : super(key: key);
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    var allCategories = getIt<PodfetchStaticCategoriesRepository>().getAll();
    return PageWrap(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Heading(
              'Categories',
              headingType: HeadingType.h2,
            ),
            GridView.count(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                ...allCategories
                    .map((category) => Text(category.title))
                    .toList()
              ],
            ),
            ListView.separated(
              primary: false,
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(allCategories[index].title),
                  trailing: Chip(
                      label: Text(
                          allCategories[index].children?.length.toString() ??
                              '0')),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: allCategories.length,
            )
          ],
        ),
      ),
    );
  }
}
