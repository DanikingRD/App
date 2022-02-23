import 'package:digital_card_app/client/screen/registration/pages/name.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String identifier = '/registration';

  const RegistrationScreen();

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NameInputPage();
  }
}
