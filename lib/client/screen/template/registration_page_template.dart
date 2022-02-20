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
  final GlobalKey<FormState> uniqueKey;
  final VoidCallback? clickHandler;
  final VoidCallback? validation;

  const RegistrationPageTemplate({
    required this.header,
    required this.firstInputLabel,
    required this.secondInputLabel,
    required this.nextWidget,
    required this.uniqueKey,
    this.clickHandler,
    this.validation, //TODO: trigger validation
  });

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
        key: uniqueKey,
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
                ),
                UnderlinedTextInput(
                  label: secondInputLabel,
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.topRight,
                  child: NavigationButton(
                    onPressed: clickHandler ??
                        RegistrationScreen.navigateTo(
                            context, nextWidget, uniqueKey),
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
}
