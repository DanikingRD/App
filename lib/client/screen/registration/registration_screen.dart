import 'package:digital_card_app/client/screen/registration/contact_page.dart';
import 'package:digital_card_app/client/screen/template/registration_page_template.dart';
import 'package:digital_card_app/client/transition/registration_page_trasition.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String identifier = '/registration';

  const RegistrationScreen();

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  static VoidCallback navigateTo(BuildContext context, Widget nextPage) {
    return () =>
        Navigator.push(context, RegistrationPageTransition(child: nextPage));
  }

  static VoidCallback navigateBack(BuildContext context) {
    return () => Navigator.pop(context);
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return const RegistrationPageTemplate(
        header: 'What\'s your name?',
        firstInputLabel: 'Enter your name',
        secondInputLabel: 'Enter your password',
        nextWidget: ContactPage(),
      );
  }
}
