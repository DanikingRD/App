import 'package:digital_card_app/client/screen/auth/registration/contact_page.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:flutter/material.dart';

class SetupAccountScreen extends StatefulWidget {

  static const String identifier = '/setup-account';

  const SetupAccountScreen();

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
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
      body: Form(
        child: Padding(
          padding: edge,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navigateBack(context),
                  const SizedBox(height: 12),
                  const Text('What\'s your name?',
                      style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 32),
                  AppUtil.textInputWithBorder(
                      ctx: context,
                      label: 'First Name',
                      action: TextInputAction.next),
                  AppUtil.textInputWithBorder(
                      ctx: context,
                      label: 'Last Name',
                      action: TextInputAction.done),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.topRight,
                    child: navigateTo(context, const ContactPage(), edge),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget navigateTo(BuildContext context, Widget nextPage, EdgeInsets padding) {
    return AppUtil.navigationButton(context, Icons.navigate_next, () {
      Navigator.pushNamed(context, ContactPage.identifier, arguments: padding);
    });
  }

  static Widget navigateBack(BuildContext context) {
    return AppUtil.navigationButton(context, Icons.navigate_before, () => Navigator.pop(context),
      
    );
  }
}
