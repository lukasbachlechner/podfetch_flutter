import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_api/repositories/categories_repository.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';

class CategoriesGridItem extends StatelessWidget {
  const CategoriesGridItem(
      {Key? key, required this.category, this.aspectRatio = 1.0})
      : super(key: key);
  final StaticCategory category;
  final double aspectRatio;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.router.push(SingleCategoryRoute(categoryId: category.id)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Icon(
                  category.iconData,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(category.title),
        ],
      ),
    );
  }
}
