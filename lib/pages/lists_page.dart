import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:podfetch_flutter/widgets/page/page_header.dart';
import '../widgets/base/page_wrap.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          PfPageHeader(
            title: 'Lists',
          ),
        ],
      ),
    );
  }
}