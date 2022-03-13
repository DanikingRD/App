import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.dark;

  void toggle(bool isDark) {
    _mode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeMode get themeMode => _mode;
  bool get isDarkMode => ThemeMode.dark == _mode;
}

final darkTheme = ThemeData(brightness: Brightness.dark);
final lightTheme = ThemeData(brightness: Brightness.light);
