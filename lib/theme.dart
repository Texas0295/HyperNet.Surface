import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kMaterialYouToggleStoreKey = 'app_theme_material_you';

class ThemeSet {
  ThemeData light;
  ThemeData dark;

  ThemeSet({required this.light, required this.dark});
}

Future<ThemeSet> createAppThemeSet({bool? useMaterial3}) async {
  return ThemeSet(
    light: await createAppTheme(Brightness.light, useMaterial3: useMaterial3),
    dark: await createAppTheme(Brightness.dark, useMaterial3: useMaterial3),
  );
}

Future<ThemeData> createAppTheme(
  Brightness brightness, {
  bool? useMaterial3,
}) async {
  final prefs = await SharedPreferences.getInstance();

  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    brightness: brightness,
  );

  final hasBackground = prefs.getBool('has_background_image') ?? false;

  return ThemeData(
    useMaterial3: useMaterial3 ?? (prefs.getBool(kMaterialYouToggleStoreKey) ?? false),
    colorScheme: colorScheme,
    brightness: brightness,
    iconTheme: IconThemeData(
      fill: 0,
      weight: 400,
      opticalSize: 20,
      color: colorScheme.onSurface,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: hasBackground ? colorScheme.primary.withOpacity(0.75) : colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
    scaffoldBackgroundColor: Colors.transparent,
  );
}
