import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  void toggle(bool isDark) {
    _mode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeMode get themeMode => _mode;
  bool get isDarkMode => ThemeMode.dark == _mode;
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
