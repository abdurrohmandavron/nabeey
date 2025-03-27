import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_state.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/constants/text_strings.dart';
import 'package:nabeey/common/widgets/appbar/appbar.dart';
import 'package:nabeey/features/authentication/screens/signup/widgets/signup_form.dart';

import '../../../../routes/routes.dart';
import '../../blocs/signup/signup_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignupBloc>(context);
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: const ADAppBar(showBackArrow: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ADSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// For Test Text
                Text(
                  ADTexts.forTest,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: ADColors.textBlue,
                      ),
                ),
                const SizedBox(height: ADSizes.sm),

                /// Sign Up text
                Text(
                  ADTexts.signup,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: ADSizes.spaceBtwSections),

                /// Form
                SignupForm(bloc: bloc),
                const SizedBox(height: ADSizes.spaceBtwSections),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(ADTexts.haveAccount),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, ADRoutes.login),
                      child: const Text(ADTexts.toLogin),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
