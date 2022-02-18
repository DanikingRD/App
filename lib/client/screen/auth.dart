import 'package:digital_card_app/server/auth_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  final AuthService _service;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthScreen(this._service);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
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
      validator: (input) {
        if (input!.isEmpty) {
          return "Please Enter Your Email";
        } else {
          return null;
        }
      },
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
      validator: (text) {
        if (text!.isEmpty) {
          return ('Password is required for login');
        } else {
          return null;
        }
      },
    );

    final loginButton = ElevatedButton(
      child: Text(
        'LOG IN',
        style:
            TextStyle(fontFamily: 'NotoSans', fontSize: 20, color: Colors.white),
      ),
      style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(32),
          backgroundColor: themeData.primaryColor),
      onPressed: (() async {}),
    );

    return Scaffold(
        backgroundColor: themeData.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text('Welcome To MyApp.', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: emailTextField,
                ),
                const SizedBox(height: 10),
                passwordTextField,
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: loginButton,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member yet? ', style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (ctx) => ))
                      },
                      child: const Text('SignUp', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      );
  }
}




