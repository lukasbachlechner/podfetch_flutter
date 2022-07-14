import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/api_provider.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/categories/categories_grid_item.dart';


class CategoriesGrid extends ConsumerWidget {
  const CategoriesGrid({Key? key, this.columnCount = 2, this.aspectRatio = 1.0})
      : super(key: key);
  final int columnCount;
  final double aspectRatio;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCategories = ref.watch(categoriesProvider).getAll();
    final rowsNeeded = (allCategories.length / columnCount).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
      child: LayoutGrid(
        rowGap: 24.0,
        columnGap: 12.0,
        columnSizes: List.filled(columnCount, 1.fr),
        rowSizes: List.filled(rowsNeeded, auto),
        children: [
          ...allCategories
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
