import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/features/authentication/blocs/login/login_state.dart';
import 'package:nabeey/routes/routes.dart';
import 'package:nabeey/utils/constants/sizes.dart';
import 'package:nabeey/utils/constants/text_strings.dart';
import 'package:nabeey/common/widgets/appbar/appbar.dart';
import '../../blocs/login/login_bloc.dart';
import '../../blocs/login/login_event.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: const ADAppBar(showBackArrow: true),
        body: Padding(
          padding: const EdgeInsets.all(ADSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ADTexts.login,
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: ADSizes.spaceBtwSections),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: ADTexts.phoneNo,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: ADSizes.spaceBtwSections),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: ADTexts.password,
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: ADSizes.spaceBtwSections),
              ElevatedButton(
                onPressed: () {
                  final bloc = BlocProvider.of<LoginBloc>(context);
                  bloc.add(LoginSubmit(
                    phone: phoneController.text.trim(),
                    password: passwordController.text.trim(),
                  ));
                },
                child: const Text(ADTexts.login),
              ),
              const SizedBox(height: ADSizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(ADTexts.noAccount),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, ADRoutes.signup),
                    child: const Text(ADTexts.toSignup),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
