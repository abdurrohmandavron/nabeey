import 'package:flutter/material.dart';
import 'package:nabeey/utils/helpers/helper_functions.dart';

import '../../../models/navigation_model.dart';

class ADNavigationBar extends StatelessWidget {
  final Color color;
  final double height;
  final double radius;
  final double? elevation;
  final int selectedIndex;
  final Color? backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationModel> destinations;

  const ADNavigationBar({
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
