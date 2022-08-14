/* import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../routes/router.gr.dart';

class SignupPage extends HookWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = useState<String>('');
    final password = useState<String>('');
    return Material(
      child: Stack(
        children: [
          AutoRouter.declarative(
            routes: (_) {
              return [
                EmailRoute(onNext: (value) {
                  email.value = value;
                }),
                if (email.value.isNotEmpty)
                  PasswordRoute(onNext: (value) {
                    password.value = value;
                    context.router.root.replaceAll([const HomeRouter()]);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Success')));
                  }),
              ];
            },
          ),
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: ElevatedButton(
                onPressed: () =>
                    context.router.root.replaceAll([const HomeRouter()]),
                child: const Text('Close')),
          ),
        ],
      ),
    );
  }
}
 */