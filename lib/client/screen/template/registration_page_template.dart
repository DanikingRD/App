import 'package:digital_card_app/client/screen/registration/registration_screen.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/common/widget/navigation_buttons.dart';
import 'package:flutter/material.dart';

class RegistrationPageTemplate extends StatelessWidget {

  final String header;
  final String firstInputLabel;
  final String secondInputLabel;
  final Widget nextWidget;

  const RegistrationPageTemplate({
    required this.header,
    required this.firstInputLabel,
    required this.secondInputLabel,
    required this.nextWidget,
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
                Util.textInputWithBorder(
                    autoFocus: true,
                    ctx: context,
                    label: firstInputLabel,
                    action: TextInputAction.next),
                Util.textInputWithBorder(
                    ctx: context,
                    label: secondInputLabel,
                    action: TextInputAction.done),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.topRight,
                  child: NavigationButton(
                    onPressed: RegistrationScreen.navigateTo(context, nextWidget),
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
