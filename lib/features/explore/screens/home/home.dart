import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/features/authentication/blocs/profile/profile_bloc.dart';

import '../category/category.dart';
import 'widgets/navigation_bar.dart';
import '../../blocs/base/base_bloc.dart';
import '../../models/navigation_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../bindings/service_locator.dart';
import '../../../../data/models/category_model.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../features/quiz/models/quiz_model.dart';
import '../../../../features/quiz/screens/quiz/quiz.dart';
import '../../../authentication/screens/profile/profile.dart';
import '../../../../features/explore/cubits/navigation/navigation_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = BlocProvider.of<HomeCubit>(context);

        return Scaffold(
          bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return ADNavigationBar(
                height: 60,
                radius: 30.0,
                color: ADColors.white,
                selectedIndex: state.index,
                selectedItemColor: const Color(0xFFF59C16),
                unselectedItemColor: dark
                    ? ADColors.white
                    : const Color.fromRGBO(17, 17, 17, 0.5),
                onDestinationSelected: cubit.onDestinationSelected,
                destinations: const [
                  NavigationModel(icon: Icon(Feather.home), label: "Asosiy"),
                  NavigationModel(
                      icon: Icon(Feather.help_circle), label: "Test"),
                  NavigationModel(
                      icon: Icon(Feather.activity), label: "Reyting"),
                  NavigationModel(icon: Icon(Feather.user), label: "Profil"),
                ],
              );
            },
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return [
                BlocProvider<BaseBloc<CategoryModel>>(
                  create: (context) => getIt<BaseBloc<CategoryModel>>(),
                  child: const CategoryScreen(),
                ),
                BlocProvider<BaseBloc<QuizModel>>(
                  create: (context) => getIt<BaseBloc<QuizModel>>(),
                  child: const QuizScreen(),
                ),
                // BlocProvider<BaseBloc<RatingModel>>(
                //   create: (context) => getIt<BaseBloc<RatingModel>>(),
                //   child: const RatingScreen(),
                // ),
                const SizedBox(), // TODO
                BlocProvider<ProfileBloc>(
                  create: (context) => getIt<ProfileBloc>(),
                  child: const ProfileScreen(),
                ),
              ][state.index];
            },
          ),
        );
      }),
    );
  }
}
