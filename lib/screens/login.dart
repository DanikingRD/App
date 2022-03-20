import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/util.dart';
import 'package:digital_card_app/widgets/text_input.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _loading = false;
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Image.asset(
              'assets/image/tapea.png',
              height: 64,
            ),
            const SizedBox(height: 64),
            TextFormInput(
              hintText: 'Enter your email',
              controller: _email,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            TextFormInput(
              controller: _password,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              password: true,
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: login,
              child: Container(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Log in'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Not a member yet? "),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: openSignUpScreen,
                  child: Container(
                    child: const Text(
                      "Sign up.",
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

  void login() async {
    setState(() {
      _loading = true;
    });
    await FirebaseAuthAPI.signIn(
      context: context,
      email: _email.text,
      password: _password.text,
      onError: (message) {
        Util.showSnackBar(context: context, content: message);
      },
      onSuccess: (user) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRouter.homePage,
          (_) => false,
        );
      },
    );
    setState(() => _loading = false);
  }

  void openSignUpScreen() {
    Navigator.pushNamed(context, AppRouter.signUpPage);
  }
}
