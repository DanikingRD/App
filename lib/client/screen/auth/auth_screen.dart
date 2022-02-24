import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/common/colors.dart';
import 'package:digital_card_app/common/widget/forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//TO-DO: IMPLEMENT CUPERTINO STYLE FOR IOS
class AuthScreen extends StatefulWidget {
  static const String identifier = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Color? iconColor;

  void setColor() {
    iconColor = homeColor;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final emailInput = TextInputForm.decoratedTextInput(
        label: 'Enter your email',
        action: TextInputAction.next,
        keybardType: TextInputType.emailAddress,
        icon: Icon(Icons.email, color: iconColor),
        controller: emailController,
        onSaved: (value) {
          emailController.text = value!;
        });
    final passwordInput = TextInputForm.decoratedTextInput(
        label: 'Enter your password',
        action: TextInputAction.done,
        obscureText: true,
        icon: const Icon(Icons.vpn_key),
        controller: passwordController);
    final loginButton = ElevatedButton(
      child: const Text('LOGIN',
          style: TextStyle(
              fontFamily: 'NotoSans', fontSize: 18, color: homeColor)),
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(24),
          backgroundColor: themeData.backgroundColor),
      onPressed: (() async {
        // Future<UserCredential?> result = _service.signIn(emailController.text, passwordController.text);
      }),
    );
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: Get.arguments,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/image/logo.png'),
            const Text('Login details',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 25),
            emailInput,
            const SizedBox(height: 25),
            passwordInput,
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: loginButton,
            ),
            const SizedBox(height: 15),
            Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: const Text('Forgot password?',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not a member yet? ',
                    style: TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () =>
                      Get.toNamed(RegistrationScreen.nameInputPage.name),
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
