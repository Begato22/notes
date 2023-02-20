import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = Colors.deepPurple;
  static Color secondryColor = Colors.grey;

  static Color lightPrimaryColor = primaryColor.withOpacity(0.5);

  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF673AB7,
    <int, Color>{
      50: Color(0xFF673AB7),
      100: Color(0xFF673AB7),
      200: Color(0xFF673AB7),
      300: Color(0xFF673AB7),
      400: Color(0xFF673AB7),
      500: Color(0xFF673AB7),
      600: Color(0xFF673AB7),
      700: Color(0xFF673AB7),
      800: Color(0xFF673AB7),
      900: Color(0xFF673AB7),
    },
  );
}
