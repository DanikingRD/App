import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ContactInputPage extends StatelessWidget {
  
  final GlobalKey<FormState> _key = GlobalKey();

  ContactInputPage();

  @override
  Widget build(BuildContext context) {
    const emailErrorMsg = 'Enter a valid email address';
    const phoneNumberErrorMsg = 'Enter a valid phone number';
    return RegistrationPageTemplate(
      header: 'How do we contact you?',
      firstInputLabel: 'Email Address',
      secondInputLabel: 'Phone Number',
      nextPageId: RegistrationScreen.passwordInputPage.name,
      globalKey: _key,
      firstKeyboardType: TextInputType.emailAddress,
      secondKeyboardType: TextInputType.emailAddress,
      canHaveEmptyFields: false,
      firstValidator: (text) {
        return EmailValidator.validate(text!) ? null : emailErrorMsg;
      },
      secondValidator: (text) {
        return text!.isNotEmpty ? null : phoneNumberErrorMsg;
      },
    );
  }
}
