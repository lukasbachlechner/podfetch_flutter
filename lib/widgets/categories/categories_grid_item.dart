import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/repositories/categories_repository.dart';
import '../../routes/router.gr.dart';

class CategoriesGridItem extends StatelessWidget {
  const CategoriesGridItem({
    Key? key,
    required this.category,
    this.aspectRatio = 1.0,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);
  final StaticCategory category;
  final double aspectRatio;
  final Function(StaticCategory category)? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(category);
        } else {
          context.router.push(SingleCategoryRoute(categoryId: category.id));
        }
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: isSelected
                      ? [
                          Theme.of(context).highlightColor,
                          Theme.of(context).highlightColor
                        ]
                      : [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColorLight
                        ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category.iconData,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(category.title),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
