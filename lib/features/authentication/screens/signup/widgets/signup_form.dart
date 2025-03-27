import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/validators/validation.dart';
import 'package:nabeey/utils/constants/text_strings.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_bloc.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_state.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_event.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key, required this.bloc});

  final SignupBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) => Form(
        key: bloc.signupFormKey,
        child: Column(
          children: [
            /// First name
            TextFormField(
              expands: false,
              controller: bloc.firstName,
              validator: (value) => Validator.validateEmptyText(ADTexts.firstName, value),
              decoration: const InputDecoration(labelText: ADTexts.firstName, prefixIcon: Icon(Iconsax.user)),
            ),
            const SizedBox(height: ADSizes.spaceBtwInputFields),

            /// Last name
            TextFormField(
              expands: false,
              controller: bloc.lastName,
              validator: (value) => Validator.validateEmptyText("Familya", value),
              decoration: const InputDecoration(labelText: ADTexts.lastName, prefixIcon: Icon(Iconsax.user)),
            ),
            const SizedBox(height: ADSizes.spaceBtwInputFields),

            /// Email
            TextFormField(
              expands: false,
              controller: bloc.email,
              validator: (value) => Validator.validateEmail(value),
              decoration: const InputDecoration(labelText: ADTexts.email, prefixIcon: Icon(Iconsax.direct_inbox)),
            ),
            const SizedBox(height: ADSizes.spaceBtwInputFields),

            /// Phone Number
            TextFormField(
              expands: false,
              controller: bloc.phoneNo,
              validator: (value) => Validator.validatePhoneNumber(value),
              decoration: const InputDecoration(labelText: ADTexts.phoneNo, prefixIcon: Icon(Iconsax.call), prefixText: '+998 '),
            ),
            const SizedBox(height: ADSizes.spaceBtwInputFields),

            /// Password
            TextFormField(
              controller: bloc.password,
              validator: (value) => Validator.validatePassword(value),
              expands: false,
              decoration: const InputDecoration(labelText: ADTexts.password, prefixIcon: Icon(Iconsax.password_check)),
            ),
            const SizedBox(height: ADSizes.spaceBtwInputFields),

            /// Submit Button
            ElevatedButton(
              onPressed: () {
                bloc.add(SignupSubmit());
                // Navigator.pop(context); // TODO
              },
              child: const Text(ADTexts.signup),
            ),
          ],
        ),
      ),
    );
  }
}
