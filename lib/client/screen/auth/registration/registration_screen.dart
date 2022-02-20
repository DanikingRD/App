import 'package:digital_card_app/client/screen/auth/registration/contact_page.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final AuthService _service;

  RegisterScreen(this._service);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    child: navigateTo(context, ContactPage(edge)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget navigateTo(BuildContext context, Widget nextPage) {
    return AppUtil.navigationButton(context, Icons.navigate_next, () {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
          return nextPage;
      }));
    });
  }

  static Widget navigateBack(BuildContext context) {
    return AppUtil.navigationButton(context, Icons.navigate_before, () => Navigator.pop(context),
      
    );
  }
}
