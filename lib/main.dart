import 'package:digital_card_app/client/screen/auth/auth_screen.dart';
import 'package:digital_card_app/client/screen/auth/registration/contact_page.dart';
import 'package:digital_card_app/client/screen/auth/registration/setup_account.dart';
import 'package:digital_card_app/client/screen/welcome/welcome_screen.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {

   static final AuthService _service = AuthService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    const themeColor = homeColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Card App',
      theme: ThemeData(
        primaryColor: themeColor,
        backgroundColor: Colors.white,
        fontFamily: 'FiraSans',
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: Colors.white
        ),
      ),
      home: WelcomeScreen(_service),
      routes: {
        AuthScreen.identifier: (ctx) => AuthScreen(),
        SetupAccountScreen.identifier: (ctx) => const SetupAccountScreen(),
        ContactPage.identifier: (ctx) => const ContactPage(),
      } ,
    );  
  }
}

