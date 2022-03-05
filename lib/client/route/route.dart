import 'package:digital_card_app/client/screen/auth/auth.dart';
import 'package:digital_card_app/client/screen/home.dart';
import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/registration/loading_screen.dart';
import 'package:digital_card_app/client/screen/registration/pages/contact.dart';
import 'package:digital_card_app/client/screen/registration/pages/name.dart';
import 'package:digital_card_app/client/screen/registration/pages/password.dart';
import 'package:digital_card_app/client/screen/welcome.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';


class RouteGenerator {

  static Route<dynamic>? generate(RouteSettings settings) {
    // Data passed when invoked
    final Object? data = settings.arguments;
    switch(settings.name) {
      case '/':
      case welcomePage: {
        return _defaultRoute(const WelcomeScreen());
      }
      case authPage: {
        return Transition(child: const AuthScreen(), transitionEffect: TransitionEffect.BOTTOM_TO_TOP);
      }
      case homePage: {
        return _defaultRoute(const HomeScreen());
      }
      case RegistrationScreen.namePage: {
        return _leftToRightAnimation(NameInputPage());
      }
      case RegistrationScreen.contactPage: {
        return _leftToRightAnimation(ContactInputPage());
      }
      case RegistrationScreen.passwordPage: {
        return _leftToRightAnimation(PasswordInputPage());
      }
      case RegistrationScreen.loading: {
        return _leftToRightAnimation(const LoadingScreen());
      }
      default: {
        return _defaultRoute(const WelcomeScreen());
      }
    }
  }
  static _leftToRightAnimation(Widget page) {
    return Transition(child: page, transitionEffect: TransitionEffect.RIGHT_TO_LEFT);
  }
  static _defaultRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  } 
}