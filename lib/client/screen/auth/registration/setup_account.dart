import 'package:digital_card_app/client/screen/auth/registration/contact_page.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/common/widget/navigation_buttons.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:flutter/material.dart';

class SetupAccountScreen extends StatefulWidget {
  static const String identifier = '/setup-account';

  const SetupAccountScreen();

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();

  static VoidCallback navigateTo(BuildContext context, EdgeInsets padding) {
    return () => Navigator.pushNamed(context, ContactPage.identifier, arguments: padding);
  }

  static VoidCallback navigateBack(BuildContext context) {
    return () => Navigator.pop(context);
  }
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final service = ModalRoute.of(context)!.settings.arguments as AuthService;
    const edge = EdgeInsets.symmetric(horizontal: 32, vertical: 64);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: 48,
        height: 48,
        child: TransparentNavigationButton(
          dir: NavigationDir.previous,
          onPressed: SetupAccountScreen.navigateBack(context)
        ),
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
                const Text('What\'s your name?',
                    style: TextStyle(fontSize: 24)),
                const SizedBox(height: 32),
                Util.textInputWithBorder(
                    autoFocus: true,
                    ctx: context,
                    label: 'First Name',
                    action: TextInputAction.next),
                Util.textInputWithBorder(
                    ctx: context,
                    label: 'Last Name',
                    action: TextInputAction.done),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.topRight,
                  child: NavigationButton(
                    onPressed: SetupAccountScreen.navigateTo(context, edge),
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
