import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/helpers/helper_functions.dart';

class ContentItem extends StatelessWidget {
  ContentItem({super.key, required this.index});

  final int index;
  final List<dynamic> type = [
    {'name': 'Maqola', 'icon': Feather.edit_3},
    {'name': 'Video', 'icon': Feather.youtube},
    {'name': 'Audio', 'icon': Feather.volume_2},
    {'name': 'Kitob', 'icon': Feather.book_open},
  ];

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        color: dark ? const Color.fromRGBO(25, 118, 210, 1) : ADColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1), blurRadius: 10.0)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(type[index]['icon']!),
              const SizedBox(height: 15),
              Text(type[index]['name'], style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          Transform.rotate(angle: -0.4, child: Align(alignment: Alignment.centerRight, child: Icon(type[index]['icon'], size: 50, color: dark ? ADColors.white.withOpacity(0.5) : Colors.grey))),
        ],
      ),
    );
  }
}
