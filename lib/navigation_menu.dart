import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/utils/constants/enums.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/helpers/helper_functions.dart';
import 'package:nabeey/features/explore/screens/home/home.dart';

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
            return NavigationBar(
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
              Container(color: ADColors.secondary),
              Container(color: ADColors.grey),
              Container(color: ADColors.success),
            ][state.index];
          },
        ),
      ),
    );
  }
}

class NavigationState extends Equatable {
  final NavigationEvent navigationEvent;
  final int index;

  const NavigationState(this.navigationEvent, this.index);

  @override
  List<Object> get props => [NavigationEvent, index];
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavigationEvent.home, 0));

  void getNavBarItem(NavigationEvent navigationEvent) {
    switch (navigationEvent) {
      case NavigationEvent.home:
        emit(const NavigationState(NavigationEvent.home, 0));
        break;
      case NavigationEvent.quiz:
        emit(const NavigationState(NavigationEvent.quiz, 1));
        break;
      case NavigationEvent.rating:
        emit(const NavigationState(NavigationEvent.rating, 2));
        break;
      case NavigationEvent.profile:
        emit(const NavigationState(NavigationEvent.profile, 3));
        break;
    }
  }
}

class NavigationBar extends StatelessWidget {
  final Color color;
  final double height;
  final double radius;
  final double? elevation;
  final int selectedIndex;
  final Color? backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  const NavigationBar({
    super.key,
    this.elevation,
    required this.color,
    this.backgroundColor,
    required this.height,
    required this.radius,
    required this.destinations,
    required this.selectedIndex,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
        boxShadow: [BoxShadow(color: dark ? Colors.grey.withOpacity(0.1) : Colors.black.withOpacity(0.1), blurRadius: 10.0, spreadRadius: 5.0)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
        child: BottomNavigationBar(
          selectedItemColor: selectedItemColor,
          unselectedItemColor: unselectedItemColor,
          backgroundColor: backgroundColor,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onDestinationSelected,
          elevation: elevation,
          items: destinations
              .map(
                (destination) => BottomNavigationBarItem(
                  icon: destination.icon,
                  label: destination.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class NavigationDestination {
  final Icon icon;
  final String label;

  const NavigationDestination({required this.icon, required this.label});
}
