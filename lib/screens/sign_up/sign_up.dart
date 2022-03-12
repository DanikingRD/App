import 'package:digital_card_app/screens/router.dart';
import 'package:flutter/material.dart';
import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _verifyPassword = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _username.dispose();
    _password.dispose();
    _verifyPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create an account",
              style: TextStyle(fontSize: 24),
            ),
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormInput(
                    controller: _username,
                    hintText: 'Enter your username',
                    textInputType: TextInputType.text,
                    validator: (text) => validate(text, 0),
                  ),
                  const SizedBox(height: 24),
                  TextFormInput(
                    hintText: 'Enter your email',
                    controller: _email,
                    textInputType: TextInputType.emailAddress,
                    validator: (text) => validate(text, 1),
                  ),
                  const SizedBox(height: 24),
                  TextFormInput(
                    controller: _password,
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    password: true,
                    validator: (text) => validate(text, 2),
                  ),
                  const SizedBox(height: 24),
                  TextFormInput(
                    controller: _verifyPassword,
                    hintText: 'Verify your password',
                    textInputType: TextInputType.text,
                    password: true,
                    validator: (text) => validate(text, 3),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                child: const Icon(
                  Icons.navigate_next_rounded,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (form.currentState!.validate()) {
                    form.currentState!.save();
                    openCreateProfileScreen();
                  }
                },
                backgroundColor: homeColor,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Container(),
              flex: 3,
            ),
            Center(
              child: Image.asset(
                "assets/image/tapea.png",
                height: 64,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Already have an account? "),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: openLoginScreen,
                  child: Container(
                    child: const Text(
                      "Log in.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String? validate(String? text, int index) {
    if (text!.isEmpty) {
      return "The field is required";
    }
    if (index == 0 && text.length < 4) {
      return "The username must be at last 4 characters long";
    }
    if (index == 2 && text.length < 6) {
      return "The password must be at least 6 characters long";
    }
    if (index == 3 && text != _password.text) {
      return "The entered passwords do not match";
    }
    return null;
  }

  void openCreateProfileScreen() {
    Navigator.pushNamed(context, AppRouter.createProfilePage, arguments: {
      "Username": _username.text,
      "Email": _email.text,
      "Password": _password.text,
    });
  }

  void openLoginScreen() {
    Navigator.pushReplacementNamed(context, AppRouter.loginPage);
  }
}
