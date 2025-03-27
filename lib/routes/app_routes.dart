import 'package:flutter/material.dart';
import 'package:nabeey/features/authentication/blocs/login/login_bloc.dart';
import 'package:nabeey/features/authentication/screens/profile/profile.dart';
import 'package:nabeey/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nabeey/features/quiz/screens/quiz/quiz.dart';
import 'package:nabeey/features/explore/screens/category/category.dart';
import 'package:nabeey/features/authentication/screens/signup/signup.dart';
import 'package:nabeey/features/authentication/blocs/signup/signup_bloc.dart';
import 'package:nabeey/bindings/service_locator.dart';
import 'package:nabeey/features/authentication/screens/login/login.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ADRoutes.home:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case ADRoutes.quiz:
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case ADRoutes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>(
            create: (context) => getIt<LoginBloc>(),
            child: const LoginScreen(),
          ),
        );
      case ADRoutes.signup:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SignupBloc>(
            create: (context) => getIt<SignupBloc>(),
            child: const SignupScreen(),
          ),
        );
      // case ADRoutes.rating:
      //   return MaterialPageRoute(builder: (_) => const RatingScreen());
      case ADRoutes.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      // case ADRoutes.onBoarding:
      //   return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      // case ADRoutes.editProfile:
      //   return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Sahifa topilmadi')),
        body: const Center(child: Text('Sahifa topilmadi!')),
      );
    });
  }
}
