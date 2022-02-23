import 'package:digital_card_app/client/screen/registration/pages/contact.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:flutter/widgets.dart';

class NameInputPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const errorMsg = "The field is required";
    return RegistrationPageTemplate(
      header: 'What\'s your name?',
      firstInputLabel: 'Enter your first name',
      secondInputLabel: 'Enter your last name',
      nextWidget: ContactInputPage(),
      globalKey: _formKey,
      firstKeyboardType: TextInputType.emailAddress,
      secondKeyboardType: TextInputType.emailAddress,
      firstValidator: (text) {
        return text!.isEmpty ? errorMsg : null;
      },
      secondValidator: (text) {
        return text!.isEmpty ? errorMsg : null;
      },
      canHaveEmptyFields: false,
    );
  }
}
