import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/colors.dart';

class ADOutlinedButtonTheme {
  ADOutlinedButtonTheme._();

  static OutlinedButtonThemeData lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ADColors.primary,
      side: const BorderSide(color: ADColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textStyle: const TextStyle(fontSize: 18, color: ADColors.primary, fontWeight: FontWeight.w600),
    ),
  );

  static OutlinedButtonThemeData darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ADColors.primary,
      side: const BorderSide(color: ADColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );
}
