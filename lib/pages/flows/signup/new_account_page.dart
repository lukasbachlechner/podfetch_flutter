import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_flutter/providers.dart';
import 'package:podfetch_flutter/widgets/flows/flow_page_wrapper.dart';
import 'package:podfetch_flutter/widgets/notifications/notification_bar.dart';

import '../../../widgets/buttons/button.dart';

bool isValidEmail(String email) {
  final regex = RegExp(
      r'''[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?''');
  return regex.hasMatch(email);
}

class NewAccountPage extends HookConsumerWidget {
  NewAccountPage({Key? key, required this.onNext}) : super(key: key);
  final Function(String email, String password) onNext;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailState = useState<String>('');
    final emailCheckLoading = useState<bool>(false);
    final emailCheckAvailable = useState(false);
    final emailCheckChecked = useState(false);
    final emailFocusNode = useFocusNode();
    final emailError = useState<String>('');

    void checkEmail() async {
      emailCheckLoading.value = true;
      emailCheckAvailable.value = false;
      emailCheckChecked.value = false;
      emailError.value = '';

      try {
        final checkEmailResponse =
            await ref.read(apiProvider).checkEmail(emailState.value);

        emailCheckChecked.value = true;
        emailCheckAvailable.value = !checkEmailResponse.isTaken;
        if (checkEmailResponse.isTaken) {
          emailError.value = 'Sorry, this e-mail address is already taken.';
        }
        emailCheckLoading.value = false;
      } catch (e) {
        print(e);
      } finally {
        emailCheckLoading.value = false;
      }
    }

    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus &&
          emailState.value.isNotEmpty &&
          isValidEmail(emailState.value)) {
        checkEmail();
      }
    });

    final passwordState = useState<String>('');
    final passwordRepeatState = useState<String>('');

    return FlowPageWrapper(
      title: 'Create Account',
      bottomSheet: PfButton(
        onPressed: () {
          if (formKey.currentState!.validate() && emailCheckAvailable.value) {
            onNext(emailState.value, passwordState.value);
          } else {
            const NotificationBar(
              message: 'Error occured.',
              notificationType: NotificationBarType.error,
            ).show(context);
          }
        },
        buttonType: ButtonType.accent,
        buttonWidth: ButtonWidth.full,
        child: const Text('Next'),
      ),
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 24.0),
              TextFormField(
                initialValue: emailState.value,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                    label: const Text('E-Mail'),
                    errorText:
                        emailError.value.isNotEmpty ? emailError.value : null,
                    suffixIcon: Container(
                      width: 12,
                      height: 12,
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: emailCheckLoading.value
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                              )
                            : emailCheckAvailable.value &&
                                    emailCheckChecked.value &&
                                    emailState.value.isNotEmpty
                                ? const Icon(
                                    BootstrapIcons.check_circle,
                                    color: Colors.green,
                                  )
                                : null,
                      ),
                    )),
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  emailState.value = value;
                  emailCheckChecked.value = false;
                },
                onFieldSubmitted: (value) async {
                  emailState.value = value;
                  checkEmail();
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty || !isValidEmail(value)) {
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
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) => passwordState.value = value,
                onChanged: (value) => passwordState.value = value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                initialValue: passwordRepeatState.value,
                decoration:
                    const InputDecoration(label: Text('Repeat password')),
                obscureText: true,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.text,
                onChanged: (value) => passwordRepeatState.value = value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    // passwordValidState.value = false;
                    return 'Please provide a password.';
                  }
                  if (value != passwordState.value) {
                    // passwordValidState.value = false;
                    return "Passwords don't match.";
                  }
                  // passwordValidState.value = true;
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
