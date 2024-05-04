import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/colors.dart';
import 'package:nabeey/utils/theme/custom_themes/text_theme.dart';
import 'package:nabeey/utils/theme/custom_themes/appbar_theme.dart';
import 'package:nabeey/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:nabeey/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:nabeey/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:nabeey/utils/theme/custom_themes/input_decoration_theme.dart';

class ADTheme {
  ADTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'SFProDisplay',
    brightness: Brightness.light,
    primaryColor: ADColors.primary,
    indicatorColor: ADColors.primary,
    textTheme: ADTextTheme.lightTextTheme,
    scaffoldBackgroundColor: ADColors.white,
    appBarTheme: ADAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: ADBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: ADElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: ADOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: ADInputDecorationTheme.lightInputDecorationTheme,
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: ADColors.primary),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'SFProDisplay',
    brightness: Brightness.dark,
    indicatorColor: ADColors.white,
    primaryColor: ADColors.primary,
    textTheme: ADTextTheme.darkTextTheme,
    scaffoldBackgroundColor: ADColors.black,
    appBarTheme: ADAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: ADBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: ADElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: ADOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: ADInputDecorationTheme.darkInputDecorationTheme,
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: ADColors.primary),
  );
}
