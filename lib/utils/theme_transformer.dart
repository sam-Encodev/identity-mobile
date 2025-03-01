import 'package:flutter/material.dart';

themeTransformer({number = 0}) {
  switch (number) {
    case 1:
      return ThemeMode.light;
    case 2:
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

themeDecoder(value) {
  switch (value) {
    case ThemeMode.light:
      return 1;
    case ThemeMode.dark:
      return 2;
    default:
      return 0;
  }
}
