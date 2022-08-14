import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:podfetch_flutter/routes/router.gr.dart';
import 'package:podfetch_flutter/theme.dart';
import 'package:podfetch_flutter/widgets/flows/flow_page_wrapper.dart';
import 'package:podfetch_flutter/widgets/typography/heading.dart';
import 'package:podfetch_flutter/widgets/utils/page_container.dart';

import '../../widgets/buttons/button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: PageContainer(
            child: Column(
              children: [
                const SizedBox(height: 48),
                AspectRatio(
                  aspectRatio: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 48.0,
                      ),
                      const SizedBox(width: 12.0),
                      const Text(
                        'Podfetch',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 32,
                      fontFamily: 'Satoshi',
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      const TextSpan(text: 'Listen to more than '),
                      TextSpan(
                        text: '4,000,000',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      const TextSpan(
                          text: ' podcasts. Anytime, anywhere. \n For '),
                      TextSpan(
                        text: 'free.',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                /*  const Text(
                  "You know what they say: there's always time for podcasts. With Podfetch, tune in anytime.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ), */
              ],
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(kPagePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PfButton(
                  onPressed: () => context.router.push(CreateAccountRoute()),
                  buttonType: ButtonType.accent,
                  buttonWidth: ButtonWidth.full,
                  isLoading: false,
                  child: const Text('Sign up'),
                ),
                const SizedBox(height: 8),
                PfButton(
                  onPressed: () => context.router.push(LoginRoute()),
                  buttonType: ButtonType.ghost,
                  buttonWidth: ButtonWidth.full,
                  isLoading: false,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
