import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:podfetch_api/repositories/categories_repository.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/categories/categories_grid_item.dart';

import '../../service_locator.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({Key? key, this.columnCount = 2, this.aspectRatio = 1.0})
      : super(key: key);
  final int columnCount;
  final double aspectRatio;
  @override
  Widget build(BuildContext context) {
    final _allCategories = getIt<PodfetchStaticCategoriesRepository>().getAll();
    final _rowsNeeded = (_allCategories.length / columnCount).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
      child: LayoutGrid(
        rowGap: 24.0,
        columnGap: 12.0,
        columnSizes: List.filled(columnCount, 1.fr),
        rowSizes: List.filled(_rowsNeeded, auto),
        children: [
          ..._allCategories
              .map(
                (category) => CategoriesGridItem(
                  category: category,
                  aspectRatio: aspectRatio,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
