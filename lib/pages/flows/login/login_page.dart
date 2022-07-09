import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/widgets/buttons/button.dart';
import 'package:podfetch_flutter/widgets/flows/flow_page_wrapper.dart';
import 'package:podfetch_flutter/widgets/notifications/notification_bar.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key, required this.onLogin}) : super(key: key);
  final Function() onLogin;

  void _tryLogin(WidgetRef ref, String email, String password,
      VoidCallback onSuccess, VoidCallback onError) async {
    final auth = await ref.watch(authProvider.notifier).login(email, password);
    if (auth) {
      onSuccess();
    } else {
      onError();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final emailState = useState<String?>('a@b.com');
    final passwordState = useState<String?>('1234');
    final formKey = GlobalKey<FormState>();

    void doLogin() {
      formKey.currentState!.validate();
      formKey.currentState!.save();
      _tryLogin(ref, emailState.value!, passwordState.value!, () {
        onLogin().then(
          (value) => const NotificationBar(
            message: 'Successfully logged in.',
            notificationType: NotificationBarType.success,
          ).show(context),
        );
        // SnackbarService.show(context, 'Successfully logged in!');
        // await context.router.pop();
        // onLogin();
      }, () {
        const NotificationBar(
          message: 'Invalid credentials.',
          notificationType: NotificationBarType.error,
        ).show(context);
      });
    }

    return FlowPageWrapper(
      title: 'Welcome back!',
      bottomSheet: PfButton(
        onPressed: doLogin,
        buttonType: ButtonType.accent,
        buttonWidth: ButtonWidth.full,
        isLoading: loading.value,
        child: const Text('Login'),
      ),
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please log in.'),
              const SizedBox(height: 32.0),
              TextFormField(
                initialValue: emailState.value,
                decoration: const InputDecoration(label: Text('E-Mail')),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => emailState.value = value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a valid e-mail address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                initialValue: passwordState.value,
                decoration: const InputDecoration(label: Text('Password')),
                obscureText: true,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.text,
                onSaved: (value) => passwordState.value = value,
                onFieldSubmitted: (_) => doLogin(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ],
    );
  }
}
