import 'dart:collection';

import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/common/widget/buttons.dart';
import 'package:digital_card_app/common/widget/forms.dart';
import 'package:flutter/material.dart';

enum RegistrationFormData {
  firstName,
  lastName,
  email,
  password,
  phoneNumber,
  dummy,
}

class RegistrationFormTemplate extends StatefulWidget {
  final String header;
  final String firstInputLabel;
  final String secondInputLabel;
  final String nextPageId;
  final GlobalKey<FormState> globalKey;
  final VoidCallback? clickHandler;
  final FormFieldValidator<String>? firstValidator;
  final FormFieldValidator<String>? secondValidator;
  final TextInputType? firstKeyboardType;
  final TextInputType? secondKeyboardType;
  final bool canHaveEmptyFields;
  final String? explanation;
  final bool hideFirstInputText;
  final bool hideSecondInputText;
  final VoidCallback? onNextButtonPressedEvent;
  final RegistrationFormData savedOnFirstInput;
  final RegistrationFormData savedOnSecondInput;
  final TextEditingController firstInputController = TextEditingController();
  final TextEditingController secondInputController = TextEditingController();
  final GlobalKey<RegistrationFormTemplateState> state;
  
  RegistrationFormTemplate({
    required this.state,
    required this.header,
    required this.firstInputLabel,
    required this.secondInputLabel,
    required this.nextPageId,
    required this.globalKey,
    this.savedOnFirstInput = RegistrationFormData.dummy,
    this.savedOnSecondInput = RegistrationFormData.dummy,
    this.clickHandler,
    this.firstValidator,
    this.secondValidator,
    this.firstKeyboardType,
    this.secondKeyboardType,
    this.canHaveEmptyFields = true,
    this.explanation,
    this.hideFirstInputText = false,
    this.hideSecondInputText = false,
    this.onNextButtonPressedEvent,
  }) : super(key: state);

  @override
  State<RegistrationFormTemplate> createState() =>
      RegistrationFormTemplateState();
}

class RegistrationFormTemplateState extends State<RegistrationFormTemplate> {
  bool _validated = false;

  static final Map<String, String> form = HashMap();

  @override
  Widget build(BuildContext context) {
    const edge = EdgeInsets.symmetric(horizontal: 32);
    var navigationButton = NavigationButton(
      onPressed: () {
        if (_validated) {
          widget.globalKey.currentState!.save();
        }
        // Get.toNamed(
        //   widget.nextPageId,
        //   arguments: form,
        // );
      },
      dir: NavigationDir.next,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          splashRadius: appSplashRadius,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.navigate_before_sharp,
            size: 40,
          ),
        )
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: widget.globalKey,
          child: Padding(
            padding: edge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(widget.header, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 10),
                widget.explanation != null
                    ? Text(widget.explanation as String)
                    : const SizedBox(),
                const SizedBox(height: 5),
                UnderlinedTextInput(
                  autoFocusable: true,
                  obscureText: widget.hideFirstInputText,
                  label: widget.firstInputLabel,
                  inputAction: TextInputAction.next,
                  validator: widget.firstValidator,
                  controller: widget.firstInputController,
                  keyboardType: widget.firstKeyboardType,
                  onChanged: (data) => {
                    widget.firstValidator == null
                        ? enableNextButtonNonValidate()
                        : validateInputs()
                  },
                  onSaved: (data) => RegistrationFormTemplateState.saveData(
                    widget.savedOnFirstInput,
                    data!,
                  ),
                ),
                UnderlinedTextInput(
                  label: widget.secondInputLabel,
                  obscureText: widget.hideSecondInputText,
                  inputAction: TextInputAction.done,
                  validator: widget.secondValidator,
                  controller: widget.secondInputController,
                  keyboardType: widget.secondKeyboardType,
                  onChanged: (data) => {
                    widget.secondValidator == null
                        ? enableNextButtonNonValidate()
                        : validateInputs()
                  },
                  onSaved: (data) => RegistrationFormTemplateState.saveData(
                    widget.savedOnSecondInput,
                    data!,
                  ),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.topRight,
                  child: widget.canHaveEmptyFields
                      ? navigationButton
                      : !_validated
                          ? LockedNavigationButton(dir: NavigationDir.next)
                          : navigationButton,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void enableNextButtonNonValidate() {
    final String fieldA = widget.firstInputController.text;
    final String fieldB = widget.secondInputController.text;
    // If the first input is not empty and the button is not enabled
    if (fieldA.isNotEmpty && !_validated) {
      // If the second input is not empty neither
      if (fieldB.isNotEmpty) {
        // Enable button
        setState(() {
          _validated = true;
        });
      }
      // Otherwise disable it if any of the text fields is empty and the button is enabled
    } else {
      if (fieldA.isEmpty || fieldB.isEmpty) {
        if (_validated) {
          setState(() {
            _validated = false;
          });
        }
      }
    }
  }

  void validateInputs() {
    final form = widget.globalKey.currentState!;
    if (form.validate()) {
      setState(() {
        _validated = true;
      });
    } else {
      setState(() {
        _validated = false;
      });
    }
  }

  static void saveData(final RegistrationFormData data, final String toSave) {
    switch (data) {
      case RegistrationFormData.firstName:
        form['firstName'] = toSave;
        break;
      case RegistrationFormData.lastName:
        form['lastName'] = toSave;
        break;
      case RegistrationFormData.email:
        form['email'] = toSave;
        break;
      case RegistrationFormData.password:
        form['password'] = toSave;
        break;
      case RegistrationFormData.phoneNumber:
        form['phoneNumber'] = toSave;
        break;
      default:
        break;
    }
  }
}
