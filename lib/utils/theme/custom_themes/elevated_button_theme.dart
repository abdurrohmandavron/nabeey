import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/colors.dart';

class ADElevatedButtonTheme {
  ADElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: ADColors.white,
      backgroundColor: ADColors.buttonPrimary,
      disabledForegroundColor: ADColors.buttonDisabled,
      disabledBackgroundColor: ADColors.buttonDisabled,
      side: const BorderSide(color: ADColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: ADColors.primary,
      disabledForegroundColor: ADColors.buttonDisabled,
      disabledBackgroundColor: ADColors.buttonDisabled,
      side: const BorderSide(color: ADColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );
}
