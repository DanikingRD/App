import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:flutter/widgets.dart';

class NameInputPage extends StatelessWidget {
  final GlobalKey<RegistrationFormTemplateState> formKey = GlobalKey();
  NameInputPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RegistrationFormTemplate(
      state: formKey,
      header: 'What\'s your name?',
      firstInputLabel: 'Enter your first name',
      secondInputLabel: 'Enter your last name',
      nextPageId: RegistrationScreen.contactInputPage.name,
      globalKey: GlobalKey(),
      firstKeyboardType: TextInputType.emailAddress,
      secondKeyboardType: TextInputType.emailAddress,
      canHaveEmptyFields: false,
      savedOnFirstInput: RegistrationFormData.firstName,
      savedOnSecondInput: RegistrationFormData.lastName,
    );
  }
}
