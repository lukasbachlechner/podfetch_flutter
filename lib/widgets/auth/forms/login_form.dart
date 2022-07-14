import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers/auth_provider.dart';
import 'package:podfetch_flutter/widgets/buttons/button.dart';
import 'package:podfetch_flutter/widgets/notifications/notification_bar.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({Key? key, required this.onLogin}) : super(key: key);
  final Future<void> Function() onLogin;

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
    final emailState = useState<String?>('');
    final passwordState = useState<String?>('');

    final formKey = useMemoized(() => GlobalKey<FormState>());

    void doLogin() {
      formKey.currentState!.validate();

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: emailState.value,
                decoration: const InputDecoration(label: Text('E-Mail')),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => emailState.value = value,
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
                keyboardType: TextInputType.text,
                onChanged: (value) => passwordState.value = value,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              PfButton(
                onPressed: doLogin,
                buttonType: ButtonType.accent,
                buttonWidth: ButtonWidth.full,
                isLoading: loading.value,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
