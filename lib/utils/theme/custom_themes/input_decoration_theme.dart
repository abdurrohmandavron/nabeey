import 'package:flutter/material.dart';
import 'package:nabeey/utils/constants/colors.dart';

class ADInputDecorationTheme {
  ADInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: Colors.grey,
    suffixIconColor: const Color.fromARGB(255, 235, 231, 231),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(width: 1, color: ADColors.borderPrimary)),
    errorBorder: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(width: 1, color: Color(0xFFD90000))),
    enabledBorder: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(width: 1, color: ADColors.borderPrimary)),
    focusedBorder: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(width: 1, color: Colors.black12)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(width: 2, color: Colors.orange)),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(width: 1, color: ADColors.white.withOpacity(0.8))),
    errorBorder: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(width: 1, color: Colors.red)),
    enabledBorder: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(width: 1, color: ADColors.white.withOpacity(0.8))),
    focusedBorder: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(width: 1, color: Colors.white)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(width: 2, color: Colors.orange)),
  );
}
