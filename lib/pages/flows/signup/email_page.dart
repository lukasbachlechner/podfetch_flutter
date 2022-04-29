import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({Key? key, required this.onNext}) : super(key: key);
  final Function(String) onNext;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Center(
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onSubmitted: (value) {
            onNext(value);
          },
        ),
      ),
    );
  }
}
