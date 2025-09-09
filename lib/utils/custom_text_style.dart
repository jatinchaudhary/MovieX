import 'package:flutter/material.dart';

class CustomTextStyle {
  static const String _fontFamily = 'Montserrat';

  static TextStyle get regular => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get medium => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get semiBold => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get bold => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get light => const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w300,
      );

  static TextStyle size(double size, {FontWeight weight = FontWeight.w400, Color? color}) => TextStyle(
        fontFamily: _fontFamily,
        fontWeight: weight,
        fontSize: size,
        color: color,
      );
}
