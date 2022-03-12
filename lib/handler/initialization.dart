import 'package:digital_card_app/screens/home.dart';
import 'package:digital_card_app/screens/login.dart';
import 'package:firebase_cloud_functions/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppInitializer extends StatefulWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    if (user == null) {
      return const LoginScreen();
    }
    return const HomeScreen();
  }
}
