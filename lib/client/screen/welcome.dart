import 'package:digital_card_app/client/screen/pages.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const SizedBox margin = SizedBox(height: 40.0);
    return Util.appScaffoldFor(
      widgets: [
        margin,
        Image.asset('assets/image/logo.png'),
        margin,
        const Text(
          'Welcome to Tapea',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        margin,
        const Text(
          'Let\'s get your new Tapea\n\t business card set up',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        margin,
        SizedBox(
          height: 100,
          width: 320,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                authPage,
              );
            },
            child: const Text(
              'GET STARTED',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
        margin,
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, authPage);
          },
          child: const Text(
            'LOG IN WITH EXISTING ACCOUNT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        margin
      ],
    );
  }
}
