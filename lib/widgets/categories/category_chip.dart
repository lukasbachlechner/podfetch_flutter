import 'package:flutter/material.dart';
import 'package:podfetch_api/podfetch_api.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip(
      {Key? key, this.category, this.content, this.onTap, this.avatar})
      : assert((category != null || content != null)),
        super(key: key);

  final StaticCategory? category;
  final Widget? content;
  final Widget? avatar;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        avatar: avatar,
        backgroundColor: Theme.of(context).primaryColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        label: category != null ? Text(category!.title) : content!,
      ),
    );
  }
}
