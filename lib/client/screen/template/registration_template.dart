import 'package:digital_card_app/client/screen/registration/registration_screen.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/common/widget/buttons.dart';
import 'package:digital_card_app/common/widget/forms.dart';
import 'package:flutter/material.dart';

class RegistrationPageTemplate extends StatelessWidget {

  final String header;
  final String firstInputLabel;
  final String secondInputLabel;
  final Widget nextWidget;
  final GlobalKey<FormState> globalKey;
  final VoidCallback? clickHandler;
  final FormFieldValidator<String>? firstValidator;
  final FormFieldValidator<String>? secondValidator;
  final TextEditingController firstInputController = TextEditingController();
  final TextEditingController secondInputController = TextEditingController();

  RegistrationPageTemplate({Key? key, 
    required this.header,
    required this.firstInputLabel,
    required this.secondInputLabel,
    required this.nextWidget,
    required this.globalKey,
    this.clickHandler,
    this.firstValidator,
    this.secondValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const edge = EdgeInsets.symmetric(horizontal: 32, vertical: 64);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: 48,
        height: 48,
        child: TransparentNavigationButton(
            dir: NavigationDir.previous,
            onPressed: RegistrationScreen.navigateBack(context)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Form(
        key: globalKey,
        child: Padding(
          padding: edge,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(header, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 32),
                UnderlinedTextInput(
                  autoFocusable: true,
                  label: firstInputLabel,
                  inputAction: TextInputAction.next,
                  validator: firstValidator,
                  controller: firstInputController,
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      checkInput();
                    }
                  },
                  onSaved: (input) => firstInputController.text = input!,
                ),
                UnderlinedTextInput(
                  label: secondInputLabel,
                  inputAction: TextInputAction.done,
                  validator: secondValidator,
                  controller: secondInputController,
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                        checkInput();
                    }
                  } ,
                  onSaved: (input) => secondInputController.text = input!,
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.topRight,
                  child: LockedNavigationButton(
                    dir: NavigationDir.next,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkInput() {
    final form = globalKey.currentState!;
    if (form.validate()) {
        form.save();
        print('Form valid!');
    } else {
      print("Not valid dude");
    }
  }
}
