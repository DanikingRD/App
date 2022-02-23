import 'package:digital_card_app/client/transition/registration_page_trasition.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/common/widget/buttons.dart';
import 'package:digital_card_app/common/widget/forms.dart';
import 'package:flutter/material.dart';

class RegistrationPageTemplate extends StatefulWidget {
  final String header;
  final String firstInputLabel;
  final String secondInputLabel;
  final Widget nextWidget;
  final GlobalKey<FormState> globalKey;
  final VoidCallback? clickHandler;
  final FormFieldValidator<String>? firstValidator;
  final FormFieldValidator<String>? secondValidator;
  final TextInputType? firstKeyboardType;
  final TextInputType? secondKeyboardType;
  final bool canHaveEmptyFields;
  final String? explanation;

  const RegistrationPageTemplate({
    Key? key,
    required this.header,
    required this.firstInputLabel,
    required this.secondInputLabel,
    required this.nextWidget,
    required this.globalKey,
    this.clickHandler,
    this.firstValidator,
    this.secondValidator,
    this.firstKeyboardType,
    this.secondKeyboardType,
    this.canHaveEmptyFields = true,
    this.explanation,
  }) : super(key: key);

  @override
  State<RegistrationPageTemplate> createState() =>
      _RegistrationPageTemplateState();
}

class _RegistrationPageTemplateState extends State<RegistrationPageTemplate> {
  final TextEditingController firstInputController = TextEditingController();
  final TextEditingController secondInputController = TextEditingController();

  bool _validated = false;

  @override
  Widget build(BuildContext context) {
    const edge = EdgeInsets.symmetric(horizontal: 32, vertical: 64);
    var navigationButton = NavigationButton(
        onPressed: () {
          Navigator.push(
              context, RegistrationPageTransition(child: widget.nextWidget));
        },
        dir: NavigationDir.next);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: 48,
        height: 48,
        child: TransparentNavigationButton(
            dir: NavigationDir.previous,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Form(
        key: widget.globalKey,
        child: Padding(
          padding: edge,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(widget.header, style: const TextStyle(fontSize: 24)),
                widget.explanation == null
                    ? const SizedBox(height: 32)
                    : Text(widget.explanation as String),
                UnderlinedTextInput(
                  autoFocusable: true,
                  label: widget.firstInputLabel,
                  inputAction: TextInputAction.next,
                  validator: widget.firstValidator,
                  controller: firstInputController,
                  keyboardType: widget.firstKeyboardType,
                  onChanged: (text) {
                    checkAllInputs();
                  },
                ),
                UnderlinedTextInput(
                  label: widget.secondInputLabel,
                  inputAction: TextInputAction.done,
                  validator: widget.secondValidator,
                  controller: secondInputController,
                  keyboardType: widget.secondKeyboardType,
                  onChanged: (text) {
                    checkAllInputs();
                  },
                ),
                const SizedBox(height: 32),
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

  void checkAllInputs() {
    final form = widget.globalKey.currentState!;
    if (form.validate()) {
      setState(() {
        _validated = true;
      });
      form.save();
    } else {
      setState(() {
        _validated = false;
      });
    }
  }
}
