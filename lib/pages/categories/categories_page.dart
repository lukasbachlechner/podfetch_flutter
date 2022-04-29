import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get_it/get_it.dart';
import 'package:podfetch_api/models/podcast.dart';
import 'package:podfetch_api/podfetch_api.dart';
import 'package:podfetch_api/providers/api_provider.dart';
import 'package:podfetch_flutter/pages/login_page.dart';
import 'package:podfetch_flutter/service_locator.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';

import '../../routes/router.gr.dart';
import '../../widgets/base/page_wrap.dart';
import '../../widgets/podcasts_scroll_list/podcasts_scroll_list.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = getIt<PodfetchApiProvider>();
    final allCategories = getIt<PodfetchStaticCategoriesRepository>().getAll();

    final rowsNeeded = (allCategories.length / 3).ceil();

    return PageWrap(
      title: 'Categories',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Heading(
              'Categories',
              headingType: HeadingType.h1,
            ),
          ],
        ),
      ),
    );
  }
}
