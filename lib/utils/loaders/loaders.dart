import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/helpers/helper_functions.dart';

class ADLoaders {
  static hideSnackBar(BuildContext context) => ScaffoldMessenger.of(context).hideCurrentSnackBar();

  static customToast(BuildContext context, {required message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: HelperFunctions.isDarkMode(context) ? ADColors.darkerGrey.withOpacity(0.9) : ADColors.grey.withOpacity(0.9),
          ),
          child: Center(child: Text(message, style: Theme.of(context).textTheme.labelLarge)),
        ),
      ),
    );
  }

  static successSnackBar(BuildContext context, {required String title, String message = '', int duration = 3}) {
    final scaffold = ScaffoldMessenger.of(Navigator.of(context).context);
    final snackBar = SnackBar(
      content: Text(title),
      backgroundColor: ADColors.primary,
      margin: const EdgeInsets.all(10.0),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: ADColors.success,
        onPressed: () => scaffold.hideCurrentSnackBar(),
      ),
      duration: Duration(seconds: duration),
    );
    scaffold.showSnackBar(snackBar);
  }

  static warningSnackBar(BuildContext context, {required String title, String message = '', int duration = 3}) {
    final scaffold = ScaffoldMessenger.of(Navigator.of(context).context);
    final snackBar = SnackBar(
      content: Text(title),
      backgroundColor: ADColors.primary,
      // margin: const EdgeInsets.all(10.0),
      // action: SnackBarAction(
      //   label: 'Yopish',
      //   textColor: ADColors.white,
      //   onPressed: () => scaffold.hideCurrentSnackBar(),
      // ),
      duration: Duration(seconds: duration),
    );
    scaffold.showSnackBar(snackBar);
  }

  static errorSnackBar(BuildContext context, {required String title, String message = '', int duration = 3}) {
    final scaffold = ScaffoldMessenger.of(Navigator.of(context).context);
    final snackBar = SnackBar(
      content: Text(title),
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(10.0),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: ADColors.white,
        onPressed: () => scaffold.hideCurrentSnackBar(),
      ),
      duration: Duration(seconds: duration),
    );
    scaffold.showSnackBar(snackBar);
  }
}
