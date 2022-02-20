import 'package:digital_card_app/client/screen/auth/registration/setup_account.dart';
import 'package:digital_card_app/client/screen/home_screen.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/common/widget/navigation_buttons.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {

  static const String identifier = '/setup/contact';

  const ContactPage();

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = ModalRoute.of(context)!.settings.arguments as EdgeInsets;
    return Scaffold(
        floatingActionButton: SizedBox(
        width: 48,
        height: 48,
        child: TransparentNavigationButton(
          dir: NavigationDir.previous,
          onPressed: SetupAccountScreen.navigateBack(context)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: Padding(
          padding: padding,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text('How do we contanct you? ', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 32),
                    Util.textInputWithBorder(ctx: context, label: 'Email Address', action: TextInputAction.next),
                    Util.textInputWithBorder(ctx: context, label: 'Phone Number', action: TextInputAction.done),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(  
                      child: const Icon(Icons.navigate_next),
                      backgroundColor: homeColor,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                           return HomeScreen();
                        }));
                      }
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