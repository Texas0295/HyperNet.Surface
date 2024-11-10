import 'package:flutter/material.dart';

class ThemeSet {
  ThemeData light;
  ThemeData dark;

  ThemeSet({required this.light, required this.dark});
}

ThemeSet createAppThemeSet() {
  return ThemeSet(
    light: createAppTheme(Brightness.light),
    dark: createAppTheme(Brightness.dark),
  );
}

ThemeData createAppTheme(Brightness brightness) {
  return ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: brightness,
    ),
    brightness: brightness,
    iconTheme: const IconThemeData(fill: 0, weight: 400, opticalSize: 20),
  );
}
