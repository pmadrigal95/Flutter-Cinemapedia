import 'package:flutter/material.dart';

/// Use Hexadecimal
/// Add: 0xff before to the hexa

class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      // colorSchemeSeed: const Color(0xFF2862F5)
      colorSchemeSeed: Colors.white,
      brightness: Brightness.dark);
}
