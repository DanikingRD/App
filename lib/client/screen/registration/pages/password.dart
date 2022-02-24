import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<RegistrationPageTemplateState> objectKey = GlobalKey();

  PasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RegistrationPageTemplate(
      key: objectKey,
      header: 'Create a password',
      firstInputLabel: 'Enter a password',
      secondInputLabel: 'Verify your password',
      nextPageId: RegistrationScreen.loadingPage.name,
      explanation: 'Your password must be at least 6 characters long.',
      hideFirstInputText: true,
      hideSecondInputText: true,
      canHaveEmptyFields: false,
      globalKey: formKey,
      firstValidator: (text) {
        if (text!.isEmpty) {
          return 'The field is required';
        }
        return null;
      },
      secondValidator: (text) {
        if (text!.isEmpty) {
          return 'The field is required';
        }
        if (text != objectKey.currentState!.widget.firstInputController.text) {
          return 'The passwords entered do not match';
        }
        return null;
      },
    );
  }
}
