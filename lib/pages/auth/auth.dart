import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/pages/pages.dart';
import 'package:digital_card_app/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_functions/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

///TO-DO:
/// ADD CONTACT US EMAIL
/// HANDLE MORE EXCEPTIONS
/// SET FORGOT PASSWORD FUNCTIONALITY
class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  Color? iconColor_1;
  Color? iconColor_2;

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)!.settings.name);
    const SizedBox margin = SizedBox(height: 36.0);
    final themeData = Theme.of(context);
    final defaultIconColor = themeData.iconTheme.color;
    final primaryColor = themeData.primaryColor;
    iconColor_1 = emailText.text.isEmpty ? defaultIconColor : primaryColor;
    iconColor_2 = passwordText.text.isEmpty ? defaultIconColor : primaryColor;
    final bool dirty_1 = emailText.text.isEmpty;
    final bool dirty_2 = passwordText.text.isEmpty;
    const Color fontColor = Colors.white;
    return Util.setScaffold(
      widgets: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                margin,
                Image.asset('assets/image/logo.png'),
                margin,
                const Text(
                  'Login details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: fontColor,
                  ),
                ),
                margin,
                _formField(
                    label: 'email',
                    icon: Icon(
                      Icons.email,
                      color: iconColor_1,
                    ),
                    context: context,
                    controller: emailText,
                    onChanged: (data) {
                      if (dirty_1 != data.isEmpty) {
                        setState(() {});
                      }
                    }),
                margin,
                _formField(
                  label: 'password',
                  icon: Icon(
                    Icons.vpn_key,
                    color: iconColor_2,
                  ),
                  context: context,
                  controller: passwordText,
                  onChanged: (data) {
                    if (dirty_2 != data.isEmpty) {
                      setState(() {});
                    }
                  },
                  obscureText: true,
                ),
                margin,
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: TextButton(
                      onPressed: () {
                        signIn(
                          service: context.read<FirebaseAuthService>(),
                          email: emailText.text,
                          password: passwordText.text,
                        );
                      },
                      child: const Text(
                        'LOGIN',
                      ),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                margin,
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                      ),
                    ),
                  ),
                ),
                margin,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member yet? ',
                      style: TextStyle(color: fontColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          registrationFormPage,
                        );
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: fontColor,
                        ),
                      ),
                    )
                  ],
                ),
                margin
              ],
            ),
          ),
        )
      ],
    );
  }

  void signIn({
    required FirebaseAuthService service,
    required String email,
    required password,
  }) async {
    try {
     // await service.signIn(email: email, password: password);
      Navigator.pushNamedAndRemoveUntil(context, homePage, (_) => false);
    } on FirebaseAuthException catch (exception) {
      switch (exception.code) {
        case 'user-not-found':
          createDialog(
            content: const Text(
              "This account doesn't exist. Looks like no account exists with this email address. Try creating an account instead by going back to the start and tapping 'Get Started'!",
            ),
          );
          break;

        case 'wrong-password':
          createDialog(
            content: const Text(
              "The password you entered was incorret. Try another passowrd or tap 'Forgot my password' to reset it.",
            ),
          );
          break;

        case 'invalid-email':
          createDialog(
            content: const Text(
              "The email you've entered is invalid. Enter a valid email and try again.",
            ),
          );
          break;

        case 'too-many-requests':
          createDialog(
            content: const Text(
              'You made many requests. Try it later',
            ),
          );
          break;
        case 'unknown':
          createDialog(
            content: const Text(
              'Unfortunately, an unknown error occurred. Apologies for the inconvenience. Try again later or contact us at @_.tapea so we can look into this error further.',
            ),
          );
      }
    }
  }

  void createDialog({required final Text content}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'GOT IT',
            ),
          )
        ],
      ),
    );
  }

  Widget _formField({
    required String label,
    bool obscureText = false,
    TextInputAction action = TextInputAction.next,
    TextInputType keyboardType = TextInputType.emailAddress,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    FormFieldSetter<String>? onSaved,
    required Icon icon,
    required BuildContext context,
  }) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            offset: Offset(1, 1),
          )
        ],
        color: Colors.white,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          border: InputBorder.none,
          labelText: 'Enter your $label',
          floatingLabelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          prefixIcon: icon,
        ),
        cursorColor: homeColor,
        obscureText: obscureText,
        textInputAction: action,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        onSaved: onSaved,
        autofocus: false,
      ),
    );
  }
}
