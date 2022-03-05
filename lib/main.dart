import 'package:digital_card_app/client/route/route.dart';
import 'package:digital_card_app/client/screen/welcome.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  //TO-DO: Look at visual density

  @override
  Widget build(BuildContext context) {
    const primaryColor = homeColor;
    const secondaryColor = Colors.white;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tapea',
      home: const WelcomeScreen(),
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: secondaryColor,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black54),
        appBarTheme: const AppBarTheme(
         backgroundColor: Colors.transparent,
         elevation: 0.0,
         foregroundColor: primaryColor
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(primaryColor),
            backgroundColor: MaterialStateProperty.all(secondaryColor),
          ),
        ),
      ),
      onGenerateRoute: RouteGenerator.generate,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   const themeColor = homeColor;
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Digital Card App',
  //    // getPages: setupNavigation(),
  //     theme: ThemeData(
  //       primaryColor: themeColor,
  //       backgroundColor: Colors.white,
  //       fontFamily: 'FiraSans',
  //       colorScheme: ThemeData().colorScheme.copyWith(primary: themeColor),
  //       appBarTheme: const AppBarTheme(
  //         systemOverlayStyle: SystemUiOverlayStyle(
  //           statusBarColor: Colors.black,
  //           statusBarBrightness: Brightness.dark
  //         ),
  //         backgroundColor: Colors.transparent,
  //         elevation: 0.0,
  //         foregroundColor: homeColor,
  //         actionsIconTheme: IconThemeData(
  //           color: homeColor,
  //         ),
  //       ),
  //     ),
  //     home: const WelcomeScreen(),
  //   );
}
