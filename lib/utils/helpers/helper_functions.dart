import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HelperFunctions {
  HelperFunctions._();

  static ThemeMode themeMode = ThemeMode.system;

  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static List<T> removeDuplicates<T>(List<T> list) => list.toSet().toList();
  static bool isDarkMode(BuildContext context) => Theme.of(context).brightness == Brightness.dark;
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static String getFormattedDate(DateTime date, {String format = 'dd-MMM-yyyy'}) => DateFormat(format).format(date);
  static String truncateText(String text, int maxLength) => text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';
  static void navigateToString(BuildContext context, Widget screen) => Navigator.push(context, MaterialPageRoute(builder: (_) => screen));

  static void showAlert(BuildContext context, String title, String message) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
        ),
      );

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        i + rowSize > widgets.length ? widgets.length : i + rowSize,
      );
      wrappedList.add(
        Row(children: rowChildren),
      );
    }
    return wrappedList;
  }
}
