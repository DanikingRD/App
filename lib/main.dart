import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/welcome.dart';
import 'package:digital_card_app/common/colors.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  static final AuthService _service = AuthService(FirebaseAuth.instance);
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
        appBarTheme: AppBarTheme(),
      ),
      home: const WelcomeScreen(),
    );
  }
}
