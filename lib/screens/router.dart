import 'package:digital_card_app/api/transition.dart';
import 'package:digital_card_app/screens/auth/recovery.dart';
import 'package:digital_card_app/screens/auth/sign_up/create__default_profile.dart';
import 'package:digital_card_app/screens/auth/sign_up/sign_up.dart';
import 'package:digital_card_app/screens/home/create_card.dart';
import 'package:digital_card_app/screens/home/home_screen_loader.dart';
import 'package:digital_card_app/screens/auth/login.dart';
import 'package:digital_card_app/screens/home/share_card_screen.dart';
import 'package:digital_card_app/screens/home/tapea_card.dart';
import 'package:digital_card_app/screens/welcome/welcome_screen_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppRouter {
  static const String welcomePage = '/welcome';
  static const String loginPage = "/login";
  static const String signUpPage = '/sign_up';
  static const String createProfilePage = '/create_profile';
  static const String homePage = '/homepage';
  static const String themeSettingsPage = '/theme_settings';
  static const String recoveryPage = '/recovery';
  static const String createCardPage = '/create_card';
  static const String cardPage = '/card';
  static const String shareCardPage = '/share';

  static Route<dynamic> init(RouteSettings settings) {
    switch (settings.name) {
      case "/":
      case welcomePage:
        return Transition(
          builder: (_) => const WelcomeScreenLayout(),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case loginPage:
        return Transition(
          builder: ((_) => const LoginScreen()),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case recoveryPage:
        return Transition(
          builder: (_) => const RecoveryScreen(),
          transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
        );
      case signUpPage:
        return Transition(
          builder: (_) => const SignUpScreen(),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case createProfilePage:
        return Transition(
          builder: (_) => CreateDefaultProfile(
            account: settings.arguments as Map<String, String>,
          ),
          transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
          settings: settings,
        );
      case homePage:
        return Transition(
          builder: (_) => const HomeScreenLoader(),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case createCardPage:
        return Transition(
          builder: (_) => const CreateCardScreen(),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case cardPage:
        return Transition(
          builder: (_) => const TapeaCardScreen(),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      case shareCardPage:
        final QrImage qrCode = settings.arguments! as QrImage;
        return Transition(
          builder: (_) => ShareCardScreen(card: qrCode),
          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
          settings: settings,
        );
      default:
        throw ('The screen is not registered');
    }
  }
}
