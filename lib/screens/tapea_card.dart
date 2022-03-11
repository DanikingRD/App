import 'package:digital_card_app/provider/user_provider.dart';
import 'package:digital_card_app/screens/home.dart';
import 'package:digital_card_app/screens/login.dart';
import 'package:firebase_cloud_functions/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TapeaCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FirestoreUser? user = Provider.of<UserProvider>(context).listener;
    if (user == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
    return ListView(
      children:  [
        const Center(
          child: Text("Profile"),
        ),
        Center(
          child: Text("Email: ${user!.email}"),
        )
      ],
    );
  }
  
}