import 'package:digital_card_app/client/screen/auth.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePageWidget());
}

class HomePageWidget extends StatelessWidget {

   static final AuthService _service = AuthService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Card App',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 66, 66),
        backgroundColor: Colors.white,
        fontFamily: 'NotoSans',
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.red,
        )
      ),
      home: AuthScreen(_service),
    );  
  }
}

