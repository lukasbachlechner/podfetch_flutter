import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';

class LoginPage extends HookWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _email = useState<String>('');
    final _password = useState<String>('');
    return Material(
      child: Stack(
        children: [
          AutoRouter.declarative(
            routes: (_) {
              return [
                EmailRoute(onNext: (value) {
                  _email.value = value;
                }),
                if (_email.value.isNotEmpty)
                  PasswordRoute(onNext: (value) {
                    _password.value = value;
                    context.router.root.replaceAll([HomeRouter()]);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Success')));
                  }),
              ];
            },
          ),
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: ElevatedButton(
                onPressed: () => context.router.root.replaceAll([HomeRouter()]),
                child: Text('Close')),
          ),
        ],
      ),
    );
  }
}
