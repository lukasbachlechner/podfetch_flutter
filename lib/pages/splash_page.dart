import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*  final timer = Timer.periodic(const Duration(seconds: 2), (_) {
      context.router.root.replace(const HomeRouter());
    }); */
    return Container(
      color: Colors.red,
      child: const Center(
        child: FlutterLogo(),
      ),
    );
  }
}
