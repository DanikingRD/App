import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PasswordPage extends StatelessWidget {
  final GlobalKey<RegistrationFormTemplateState> formKey = GlobalKey();
  static const _requiredPasswordLength = 6;

  PasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationFormTemplate(
      state: formKey,
      header: 'Create a password',
      firstInputLabel: 'Enter a password',
      secondInputLabel: 'Verify your password',
      nextPageId: RegistrationScreen.loadingPage.name,
      explanation: 'Your password must be at least 6 characters long.',
      hideFirstInputText: true,
      hideSecondInputText: true,
      canHaveEmptyFields: false,
      globalKey: GlobalKey(),
      firstValidator: (content) {
        final String data = content!;
        if (data.isEmpty) {
          return 'The field is required';
        } else if (data.length < _requiredPasswordLength) {
          return 'Enter a 6 characters long password';
        } else {
          return null;
        }
      },
      secondValidator: (content) {
        final String data = content!;
        if (data.isEmpty) {
          return 'The field is required';
        } else if (data !=
            formKey.currentState!.widget.firstInputController.text) {
          return 'The passwords entered do not match';
        } else {
          return null;
        }
      },
      savedOnSecondInput: RegistrationFormData.password,
    );
  }
}
