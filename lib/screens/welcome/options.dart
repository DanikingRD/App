import 'package:digital_card_app/screens/router.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        children: [
          Image.asset("assets/image/tapea.png", width: 240, height: 150),
          Text(
            "Welcome to Tapea",
            style: themeData.textTheme.headline5!.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          Text(
            "Let's get your new Tapea business card set up",
            style: themeData.textTheme.headline5!.copyWith(
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(child: Container()),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                getColor(isDarkMode),
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, AppRouter.signUpPage),
            child: Text(
              "GET STARTED",
              style: themeData.textTheme.button!.copyWith(
                color: isDarkMode ? Colors.black : Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(child: Container()),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: getColor(isDarkMode),
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, AppRouter.loginPage),
            child: Text(
              "LOG IN WITH EXISTING ACCOUNT",
              style: themeData.textTheme.button!.copyWith(
                color: getColor(isDarkMode),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  Color getColor(bool isDarkMode) {
    return isDarkMode ? Colors.white : Colors.black;
  }
}
