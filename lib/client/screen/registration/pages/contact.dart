import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ContactInputPage extends StatelessWidget {
  final GlobalKey<RegistrationFormTemplateState> formKey = GlobalKey();

  ContactInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const emailErrorMsg = 'Enter a valid email address';
    const phoneNumberErrorMsg = 'Enter a valid phone number';
    return RegistrationFormTemplate(
      state: formKey,
      header: 'How do we contact you?',
      firstInputLabel: 'Email Address',
      secondInputLabel: 'Phone Number',
      nextPageId: RegistrationScreen.passwordPage,
      globalKey: GlobalKey(),
      firstKeyboardType: TextInputType.emailAddress,
      secondKeyboardType: TextInputType.emailAddress,
      canHaveEmptyFields: false,
      firstValidator: (text) {
        return EmailValidator.validate(text!) ? null : emailErrorMsg;
      },
      secondValidator: (text) {
        return text!.isNotEmpty ? null : phoneNumberErrorMsg;
      },
      savedOnFirstInput: RegistrationFormData.email,
      savedOnSecondInput: RegistrationFormData.phoneNumber,
    );
  }
}
