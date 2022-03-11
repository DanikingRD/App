import 'package:digital_card_app/screens/home.dart';
import 'package:digital_card_app/provider/user_provider.dart';
import 'package:digital_card_app/screens/login.dart';
import 'package:firebase_cloud_functions/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthEventHandler extends StatefulWidget {
  const AuthEventHandler({Key? key}) : super(key: key);

  @override
  State<AuthEventHandler> createState() => _AuthEventHandlerState();
}

class _AuthEventHandlerState extends State<AuthEventHandler> {
  @override
  void initState() {
    super.initState();
    initProvider();
  }

  void initProvider() async {
    final UserProvider _user = Provider.of(context, listen: false);
    await _user.init();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreUser? listener = Provider.of<UserProvider>(context).listener;
    if (listener == null) {
      return const LoginScreen();
    } 
    return const HomeScreen();
  }
}
