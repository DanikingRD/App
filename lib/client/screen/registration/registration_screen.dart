import 'package:digital_card_app/client/screen/registration/pages/name.dart';
import 'package:digital_card_app/client/transition/registration_page_trasition.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String identifier = '/registration';

  const RegistrationScreen();

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  static VoidCallback navigateTo(BuildContext context, Widget nextPage) {
    return () => Navigator.push(context, RegistrationPageTransition(child: nextPage));
  }

  static VoidCallback navigateBack(BuildContext context) {
    return () => Navigator.pop(context);
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NameInputPage();
  }
}
