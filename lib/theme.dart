import 'package:flutter/material.dart';

class ThemeSet {
  ThemeData light;
  ThemeData dark;

  ThemeSet({required this.light, required this.dark});
}

ThemeSet createAppThemeSet() {
  return ThemeSet(
    light: createAppTheme(),
    dark: createAppTheme(),
  );
}

ThemeData createAppTheme() {
  return ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(fill: 0, weight: 400, opticalSize: 20),
  );
}
