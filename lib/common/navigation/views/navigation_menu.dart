import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/features/quiz/screens/quiz.dart';
import 'package:nabeey/utils/constants/enums.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/helpers/helper_functions.dart';
import 'package:nabeey/features/explore/screens/home/home.dart';
import 'package:nabeey/common/navigation/views/navigation_bar.dart';
import 'package:nabeey/common/navigation/viewmodels/navigation_controller.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return ADNavigationBar(
              height: 60,
              radius: 30.0,
              color: ADColors.white,
              selectedIndex: state.index,
              selectedItemColor: const Color(0xFFF59C16),
              unselectedItemColor: dark ? ADColors.white : const Color.fromRGBO(17, 17, 17, 0.5),
              onDestinationSelected: (index) {
                if (index == 0) {
                  BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavigationEvent.home);
                } else if (index == 1) {
                  BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavigationEvent.quiz);
                } else if (index == 2) {
                  BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavigationEvent.rating);
                } else if (index == 3) {
                  BlocProvider.of<NavigationCubit>(context).getNavBarItem(NavigationEvent.profile);
                }
              },
              destinations: const [
                NavigationDestination(icon: Icon(Feather.home), label: "Asosiy"),
                NavigationDestination(icon: Icon(Feather.help_circle), label: "Test"),
                NavigationDestination(icon: Icon(Feather.activity), label: "Reyting"),
                NavigationDestination(icon: Icon(Feather.user), label: "Profil"),
              ],
            );
          },
        ),
        body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return [
              const HomeScreen(),
              const QuizScreen(),
              Container(color: ADColors.grey),
              Container(color: ADColors.success),
            ][state.index];
          },
        ),
      ),
    );
  }
}
