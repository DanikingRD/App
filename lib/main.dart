

import 'package:digital_card_app/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(List<String> args) {
  runApp(HomePageWidget());
}

class HomePageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Card App',
      theme: ThemeData(
        primarySwatch: Colors.blue 
      ),
      home: AuthScreen(),
    );
  }
}

