import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final emailTextField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onSaved: (v) {
        print("onSaved() $v");
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Email",
      ),
    );

    final passwordTextField = TextFormField(
      autofocus: false,
      controller: passwordController,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.vpn_key),
      ),
      obscureText: true, // Hides the password
    );

    final loginButton = ElevatedButton(
      child: const Text(
        'LOG IN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(14)),
      onPressed: (() => {}),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                emailTextField,
                const SizedBox(height: 10),
                passwordTextField,
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: loginButton,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Not a member yet? '),
                    Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
