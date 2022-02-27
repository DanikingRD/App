import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/welcome.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  //TO-DO: Look at visual density
  @override
  Widget build(BuildContext context) {
    const themeColor = homeColor;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Card App',
      getPages: setupNavigation(),
      theme: ThemeData(
        primaryColor: themeColor,
        backgroundColor: Colors.white,
        fontFamily: 'FiraSans',
        colorScheme: ThemeData().colorScheme.copyWith(primary: themeColor),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: homeColor,
          actionsIconTheme: IconThemeData(
            color: homeColor,
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
