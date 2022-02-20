import 'package:digital_card_app/client/screen/auth/registration/registration_screen.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:flutter/material.dart';

//TO-DO: IMPLEMENT CUPERTINO STYLE FOR IOS
class AuthScreen extends StatelessWidget {
  final AuthService _service;
  final Gradient _linearGradient;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthScreen(this._service, this._linearGradient, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final emailInput = AppUtil.textInput(
        color: Colors.white,
        icon: const Icon(Icons.email),
        text: 'Enter your email');
    final passwordInput = AppUtil.textInput(
        color: Colors.white,
        icon: const Icon(Icons.vpn_key),
        text: 'Enter your password');
    final loginButton = ElevatedButton(
      child: const Text('LOGIN', style: TextStyle(fontFamily: 'NotoSans', fontSize: 18, color: primaryColor)),
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
          gradient: _linearGradient,
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
            SizedBox(width: double.infinity, child: loginButton,),
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
                  onTap: () => openRegisterScreen(context),
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

  void openRegisterScreen(BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (_) {
      return RegisterScreen(_service);
    }));
  }
}
