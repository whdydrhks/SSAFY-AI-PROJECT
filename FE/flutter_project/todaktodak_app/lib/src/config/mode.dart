import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

class Mode {
  static Color boxMode(ThemeMode currentMode) {
    switch (currentMode) {
      case ThemeMode.dark:
        return Color(0xff292929);
      case ThemeMode.light:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  static Color textMode(ThemeMode currentMode) {
    switch (currentMode) {
      case ThemeMode.dark:
        return Colors.white;
      case ThemeMode.light:
        return Palette.blackTextColor;
      default:
        return Palette.blackTextColor;
    }
  }

  static Color shadowMode(ThemeMode currentMode) {
    switch (currentMode) {
      case ThemeMode.dark:
        return Color(0xff292929);
      case ThemeMode.light:
        return Color(0x35531F13);
      default:
        return Color(0x35531F13);
    }
  }
}
