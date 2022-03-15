import 'package:digital_card_app/api/transition.dart';
import 'package:digital_card_app/screens/home/home.dart';
import 'package:digital_card_app/screens/home/settings/theme.dart';
import 'package:digital_card_app/screens/login.dart';
import 'package:digital_card_app/screens/sign_up/create_profile.dart';
import 'package:digital_card_app/screens/sign_up/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String loginPage = "/login";
  static const String signUpPage = '/sign_up';
  static const String createProfilePage = '/create_profile';
  static const String homePage = '/homepage';
  static const String themeSettingsPage = '/theme_settings';

  static Route<dynamic> init(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return Transition(
          builder: ((_) => const LoginScreen()),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case signUpPage:
        return Transition(
          builder: (_) => const SignUpScreen(),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case createProfilePage:
        return Transition(
          builder: (_) => CreateProfile(
            account: settings.arguments as Map<String, String>,
          ),
          transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
          settings: settings,
        );
      case homePage:
        return Transition(
          builder: (_) => HomeScreen(),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case themeSettingsPage:
        return Transition(
          builder: (_) => const ThemeSettingsScreen(),
          transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
          settings: settings,
        );
      default:
        throw ('The screen is not registered');
    }
  }
}
