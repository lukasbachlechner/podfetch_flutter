import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PfHtml extends StatelessWidget {
  const PfHtml({Key? key, this.data}) : super(key: key);

  final String? data;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        "body": Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          lineHeight: LineHeight.number(1.2),
        ),
        "a": Style(color: Colors.white)
      },
    );
  }
}
