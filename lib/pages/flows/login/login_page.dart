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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = useState(false);
    final emailState = useState<String?>('a@b.com');
    final passwordState = useState<String?>('1234');
    final formKey = GlobalKey<FormState>();
    return FlowPageWrapper(
      title: 'Welcome back!',
      bottomSheet: PfButton(
        onPressed: () async {
          formKey.currentState!.save();
          final auth = await ref
              .read(authProvider.notifier)
              .login(emailState.value!, passwordState.value!);
          if (auth) {
            await context.router.pop().then((_) {
              const NotificationBar(
                message: 'Logged in.',
                notificationType: NotificationBarType.success,
              ).show(context);
            });

            return onLogin();
          } else {
            await const NotificationBar(
              message: 'Wrong credentials :(',
              notificationType: NotificationBarType.error,
            ).show(context);
          }
        },
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
                keyboardType: TextInputType.text,
                onSaved: (value) => passwordState.value = value,
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
