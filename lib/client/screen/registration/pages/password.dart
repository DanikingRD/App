import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:flutter/widgets.dart';

class PasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegistrationPageTemplate(
      header: 'Create a password',
      firstInputLabel: 'Enter a password',
      secondInputLabel: 'Verify your password',
      nextWidget: Text(''),
      explanation: 'Your password must be at least 6 characters long',
      globalKey: GlobalKey(),
    );
  }
}
