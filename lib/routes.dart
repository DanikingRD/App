import 'dart:collection';

import 'package:digital_card_app/api/transition.dart';
import 'package:digital_card_app/pages/auth/auth.dart';
import 'package:digital_card_app/pages/form/form_stepper.dart';
import 'package:digital_card_app/screens/home.dart';
import 'package:digital_card_app/pages/pages.dart';
import 'package:digital_card_app/pages/welcome.dart';


import 'package:flutter/material.dart';

class RouteGenerator {
  static final Map<String, Widget> _internalMap = {
    welcomePage: const WelcomeScreen(),
    authPage: const AuthScreen(),
    registrationFormPage: const RegistrationForm(),
    homePage: const HomeScreen(),
   // manageAccountPage: (),
  };

  static Route<dynamic>? generate(RouteSettings settings) {
    final String name = settings.name!;
    final Object? args = settings.arguments;
    final Widget entry = _internalMap[name]!;
    switch (name) {
      case welcomePage:
        return Transition(
          child: entry,
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case authPage:
        return Transition(
          child: entry,
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case registrationFormPage:
        return Transition(
          child: entry,
          transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
          settings: settings,
          arguments: args,
        );
      case homePage:
        return Transition(
          child: entry,
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case manageAccountPage:
        return Transition(
          child: entry,
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (_) => _internalMap[welcomePage]!);
    }
  }
}
