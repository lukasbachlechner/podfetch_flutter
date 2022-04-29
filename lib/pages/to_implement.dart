import 'package:flutter/material.dart';
import '../widgets/base/page_wrap.dart';

class ToImplement extends StatelessWidget {
  const ToImplement({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return PageWrap(
      child: Center(
        child: Column(
          children: [
            const Text('To Implement'),
            Text(title),
          ],
        ),
      ),
    );
  }
}
