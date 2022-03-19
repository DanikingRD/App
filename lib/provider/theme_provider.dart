import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider with ChangeNotifier {
  static const String lightThemeId = "light";
  static const String darkThemeId = "dark";
  static const String systemThemeId = "system";
  ThemeMode _mode = ThemeMode.system;

  void toggle(bool isDark) {
    _mode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  String get id => getIdByTheme(_mode);
  ThemeMode get themeMode => _mode;

  bool isDarkMode(BuildContext context) {
    if (_mode == ThemeMode.dark) {
      return true;
    } else {
      return _mode == ThemeMode.system &&
          MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  static ThemeMode getThemeById(String name) {
    switch (name) {
      case lightThemeId:
        return ThemeMode.light;
      case darkThemeId:
        return ThemeMode.dark;
      case systemThemeId:
        return ThemeMode.system;
    }
    throw ("$name is not a valid theme id");
  }

  static String getIdByTheme(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return lightThemeId;
      case ThemeMode.dark:
        return darkThemeId;
      case ThemeMode.system:
        return systemThemeId;
    }
  }
}
