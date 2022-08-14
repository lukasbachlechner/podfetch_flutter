import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:podfetch_api/models/user.dart';
import 'package:podfetch_api/requests/signup_request.dart';
import 'package:podfetch_flutter/pages/flows/signup/new_account_page.dart';
import 'package:podfetch_flutter/providers.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/widgets/flows/flow_page_wrapper.dart';

class CreateAccountPage extends HookConsumerWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState('');
    final password = useState('');
    final categoryIds = useState([]);

    Future<void> trySignup() async {
      try {
        final user = await ref.watch(apiProvider).signUp(
              SignupRequest(
                email: email.value,
                password: password.value,
                passwordConfirmation: password.value,
                categoryPreferences:
                    categoryIds.value.map((id) => int.parse(id)).toList(),
              ),
            );
        await ref
            .watch(authProvider.notifier)
            .login(user.email, password.value);
      } catch (e) {
        print(e);
      }
    }

    return AutoRouter.declarative(
      routes: (_) => [
        NewAccountRoute(
          onNext: (emailToUse, passwordToUse) {
            email.value = emailToUse;
            password.value = passwordToUse;
          },
        ),
        if (email.value.isNotEmpty && password.value.isNotEmpty)
          ChooseCategoriesRoute(onNext: (List<String?> categoryIdsToUse) {
            categoryIds.value = categoryIdsToUse;

            trySignup();
          }),
      ],
    );
  }
}
