import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:flutter/widgets.dart';

class NameInputPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  NameInputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const errorMsg = "The field is required";
    return RegistrationPageTemplate(
      header: 'What\'s your name?',
      firstInputLabel: 'Enter your first name',
      secondInputLabel: 'Enter your last name',
      nextPageId: RegistrationScreen.contactInputPage.name,
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
