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

  ThemeMode get themeMode => _mode;
  bool get isDarkMode => ThemeMode.dark == _mode;

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

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  canvasColor: Colors.black,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0.25,
    shadowColor: Colors.white,
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[900]),
  colorScheme: const ColorScheme.dark(),
);
final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  canvasColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0.25,
    shadowColor: Colors.black,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(fillColor: Colors.grey[300]),
  colorScheme: const ColorScheme.light(),
);
