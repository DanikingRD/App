import 'package:digital_card_app/client/screen/auth/auth_screen.dart';
import 'package:digital_card_app/client/screen/home.dart';
import 'package:digital_card_app/client/screen/registration/loading_screen.dart';
import 'package:digital_card_app/client/screen/registration/pages/contact.dart';
import 'package:digital_card_app/client/screen/registration/pages/name.dart';
import 'package:digital_card_app/client/screen/registration/pages/password.dart';
import 'package:digital_card_app/client/screen/user/settings_list.dart';
import 'package:get/get.dart';

import 'welcome.dart';

final GetPage welcomePage = GetPage(
  name: '/welcome',
  page: () => const WelcomeScreen(),
);

final GetPage authPage = GetPage(
  name: '/auth',
  page: () => const AuthScreen(),
);

class RegistrationScreen {
  static const transitionDuration = Duration(milliseconds: 250);
  static const pageTransition = Transition.rightToLeft;

  static final GetPage nameInputPage = GetPage(
    name: '/name',
    page: () => NameInputPage(),
    transition: pageTransition,
    transitionDuration: transitionDuration,
  );
  static final GetPage contactInputPage = GetPage(
    name: '/contact',
    page: () => ContactInputPage(),
    transition: pageTransition,
    transitionDuration: transitionDuration,
  );
  static final GetPage passwordInputPage = GetPage(
    name: '/password',
    page: () => PasswordPage(),
    transition: pageTransition,
    transitionDuration: transitionDuration,
  );
  static final GetPage loadingPage = GetPage(
    name: '/finishing_registration',
    page: () => const LoadingScreen(),
    transition: pageTransition,
    transitionDuration: transitionDuration,
  );
}

final GetPage homePage = GetPage(
  name: '/home',
  page: () => const HomeScreen(),
);

final GetPage settingsListPage =
    GetPage(name: '/settings_list', page: () => SettingsListScreen());

List<GetPage<dynamic>> setupNavigation() {
  return [
    welcomePage,
    authPage,
    RegistrationScreen.nameInputPage,
    RegistrationScreen.contactInputPage,
    RegistrationScreen.passwordInputPage,
    RegistrationScreen.loadingPage,
    homePage,
    settingsListPage
  ];
}
