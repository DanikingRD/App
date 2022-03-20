import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/provider/theme_provider.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 75,
            ),
            Image.asset("assets/image/tapea.png"),
            Expanded(
              child: Image.asset(
                "assets/image/light_card.png",
              ),
              flex: 3,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "DIGITAL BUSINESS CARD\n",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: "TO LEVEL UP YOUR BUSINESS",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouter.loginPage,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: logoRedColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "GET STARTED",
                          style: Theme.of(context).textTheme.button!,
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
