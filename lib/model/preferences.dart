import 'package:digital_card_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';

class UserPreferences {
  final String uid;
  final String theme;

  const UserPreferences({
    required this.uid,
    required this.theme,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      uid: json["uid"],
      theme: json["theme"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "theme": theme,
    };
  }

  ThemeMode get themeMode => ThemeProvider.getThemeById(theme);

  @override
  String toString() => 'UserPreferences(uid: $uid, theme: $theme)';
}
