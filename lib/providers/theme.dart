import 'package:flutter/foundation.dart';
import 'package:surface/theme.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeSet theme;

  ThemeProvider() {
    theme = createAppThemeSet();
  }
}
