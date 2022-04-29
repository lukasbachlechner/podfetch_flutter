import 'package:flutter/material.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({Key? key, required this.onNext}) : super(key: key);
  final Function(String) onNext;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: TextField(onSubmitted: (value) {
          onNext(value);
        }),
      ),
    );
  }
}
