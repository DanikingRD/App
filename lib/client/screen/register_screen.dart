import 'package:digital_card_app/client/screen/home_screen.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:digital_card_app/server/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 36),
              const SizedBox(
                height: 30,
                child: Center(
                    child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('What\'s your name ?',
                      style: TextStyle(fontSize: 26)),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36, right: 36),
                child: Column(
                  children: [
                    AppUtil.textInputWithBorder(
                      label: 'Enter your first name',
                      controller: firstNameController,
                      action: TextInputAction.next,
                      ctx: context,
                    ),
                    AppUtil.textInputWithBorder(
                      label: 'Enter your last name',
                      controller: lastNameController,
                      action: TextInputAction.done,
                      ctx: context,
                    ),
                    SizedBox(height: 24),
                    const SizedBox(
                      height: 30,
                      child: Center(
                          child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'Email and Password',
                          style: TextStyle(fontSize: 26),
                        ),
                      )),
                    ),
                    AppUtil.textInputWithBorder(
                      label: 'Enter your email address',
                      controller: emailController,
                      action: TextInputAction.next,
                      ctx: context,
                    ),
                    AppUtil.textInputWithBorder(
                      label: 'Enter your password',
                      controller: passwordController,
                      action: TextInputAction.done,
                      ctx: context,
                      hiddenText: true,
                    ),
                    SizedBox(height: 30),
                    FloatingActionButton(
                      child: Icon(Icons.done_sharp),
                      onPressed: (() async {
                        print(emailController.text);
                          final result = widget._service.createUser(emailController.text, passwordController.text);
                          if (result != null) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return HomeScreen();
                            }));
                          }
                      }),
                      elevation: 12,
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
