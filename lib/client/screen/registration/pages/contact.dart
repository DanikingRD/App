import 'package:digital_card_app/client/screen/home_screen.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:flutter/material.dart';

class ContactInputPage extends StatelessWidget {
  static const String identifier = '/setup/contact';

  final GlobalKey<FormState> _key = GlobalKey();

  ContactInputPage();

  @override
  Widget build(BuildContext context) {
    return RegistrationPageTemplate(
      header: 'How do we contact you?',
      firstInputLabel: 'Email Address',
      secondInputLabel: 'Phone Number',
      nextWidget: HomeScreen(),
      globalKey: _key,
      clickHandler: () => {
        print("validating()"),
      },
      
    );
  }

  
}
