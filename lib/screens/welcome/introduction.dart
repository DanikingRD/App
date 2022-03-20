import 'package:digital_card_app/provider/theme_provider.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  String getModel(bool isDarkMode) {
    if (isDarkMode) {
      return "assets/model/animation/reading_card_light_theme.json";
    } else {
      return "assets/model/animation/reading_card_dark_theme.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/image/tapea.png", width: 240, height: 220),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "DIGITAL BUSINESS CARD\n",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextSpan(
                  text: "TO LEVEL UP YOUR BUSINESS",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          LottieBuilder.asset(
            getModel(isDarkMode),
            repeat: false,
          ),
        ],
      ),
    );
  }
}
