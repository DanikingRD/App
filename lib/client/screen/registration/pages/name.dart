import 'package:digital_card_app/client/screen/registration/pages/contact.dart';
import 'package:digital_card_app/client/screen/template/registration_template.dart';
import 'package:flutter/widgets.dart';

class NameInputPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return RegistrationPageTemplate(
        header: 'What\'s your name?',
        firstInputLabel: 'Enter your first name',
        secondInputLabel: 'Enter your last name',
        nextWidget: ContactInputPage(),
        globalKey: _formKey,
        firstValidator: (input)  {
          if (input!.isEmpty) {
            return 'The field is empty';
          } 
          return null;
        },
        secondValidator: (input) {
          if (input!.isEmpty) {
            return 'The field is empty';
          } 
          return null;
      },
    );
  }


}
  
