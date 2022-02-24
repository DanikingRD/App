import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/common/widget/buttons.dart';
import 'package:digital_card_app/common/widget/forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPageTemplate extends StatefulWidget {
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
  final TextEditingController firstInputController = TextEditingController();
  final TextEditingController secondInputController = TextEditingController();

  RegistrationPageTemplate({
    Key? key,
    required this.header,
    required this.firstInputLabel,
    required this.secondInputLabel,
    required this.nextPageId,
    required this.globalKey,
    this.clickHandler,
    this.firstValidator,
    this.secondValidator,
    this.firstKeyboardType,
    this.secondKeyboardType,
    this.canHaveEmptyFields = true,
    this.explanation,
    this.hideFirstInputText = false,
    this.hideSecondInputText = false,
  }) : super(key: key);

  @override
  State<RegistrationPageTemplate> createState() =>
      RegistrationPageTemplateState();
}

class RegistrationPageTemplateState extends State<RegistrationPageTemplate> {
  bool _validated = false;

  @override
  Widget build(BuildContext context) {
    const edge = EdgeInsets.symmetric(horizontal: 32, vertical: 64);
    var navigationButton = NavigationButton(
        onPressed: () {
          Get.toNamed(widget.nextPageId);
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
                const SizedBox(height: 20),
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
                  onChanged: (text) {
                    checkAllInputs();
                  },
                ),
                UnderlinedTextInput(
                  label: widget.secondInputLabel,
                  obscureText: widget.hideSecondInputText,
                  inputAction: TextInputAction.done,
                  validator: widget.secondValidator,
                  controller: widget.secondInputController,
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
