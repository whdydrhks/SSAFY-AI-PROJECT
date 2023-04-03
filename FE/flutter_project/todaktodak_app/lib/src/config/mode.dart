import 'package:flutter/material.dart';
import 'package:test_app/src/config/palette.dart';

class Mode {
  static Color boxMode(ThemeMode currentMode) {
    switch (currentMode) {
      case ThemeMode.dark:
        return const Color(0xff292929);

      default:
        return Colors.white;
    }
  }

  static Color textMode(ThemeMode currentMode) {
    switch (currentMode) {
      case ThemeMode.dark:
        return Colors.white;

      default:
        return Palette.blackTextColor;
    }
  }

  static Color shadowMode(ThemeMode currentMode) {
    switch (currentMode) {
      case ThemeMode.dark:
        return const Color(0xff292929);

      default:
        return const Color(0x35531F13);
    }
  }
}
