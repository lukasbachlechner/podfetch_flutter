import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/podfetch_api.dart';
import '../../providers.dart';
import '../../providers/api_provider.dart';
import '../../theme.dart';
import 'categories_grid_item.dart';

class CategoriesGrid extends HookConsumerWidget {
  const CategoriesGrid({
    Key? key,
    this.columnCount = 2,
    this.aspectRatio = 2,
    this.inPageContainer = true,
    this.selectable = false,
    this.onSelectedCategoriesChange,
  }) : super(key: key);

  final int columnCount;
  final double aspectRatio;
  final bool inPageContainer;
  final Function(List<StaticCategory> categories)? onSelectedCategoriesChange;
  final bool selectable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCategories = ref.watch(categoriesProvider).getAll();
    final rowsNeeded = (allCategories.length / columnCount).ceil();

    final selectedCategories = useState<List<StaticCategory>>([]);

    return Padding(
      padding: inPageContainer
          ? const EdgeInsets.symmetric(horizontal: kPagePadding)
          : EdgeInsets.zero,
      child: LayoutGrid(
        rowGap: 12.0,
        columnGap: 12.0,
        columnSizes: List.filled(columnCount, 1.fr),
        rowSizes: List.filled(rowsNeeded, auto),
        children: [
          ...allCategories
              .map(
                (category) => CategoriesGridItem(
                  category: category,
                  aspectRatio: aspectRatio,
                  onTap: selectable
                      ? (category) {
                          final newState = [...selectedCategories.value];
                          if (selectedCategories.value.contains(category)) {
                            newState.remove(category);
                          } else {
                            newState.add(category);
                          }
                          selectedCategories.value = newState;
                          if (onSelectedCategoriesChange != null) {
                            onSelectedCategoriesChange!(newState);
                          }
                        }
                      : null,
                  isSelected:
                      selectable && selectedCategories.value.contains(category),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
