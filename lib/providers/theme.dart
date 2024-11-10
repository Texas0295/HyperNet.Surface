import 'package:flutter/foundation.dart';
import 'package:surface/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeSet? theme;

  ThemeProvider() {
    createAppThemeSet().then((value) {
      theme = value;
      notifyListeners();
    });
  }

  void reloadTheme({bool? useMaterial3}) {
    createAppThemeSet().then((value) {
      theme = value;
      notifyListeners();
    });
  }
}
