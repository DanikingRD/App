import 'package:digital_card_app/handler/initialization.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:firebase_cloud_functions/entry_point.dart';
import 'package:firebase_cloud_functions/user/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_card_app/constants.dart';

Future<void> main(List<String> args) async {
  await FirebaseCloudFunctions.init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  //TO-DO: Look at visual density

  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser?>.value(
      value: FirebaseCloudServices.authService.authStateChanges(),
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tapea',
        theme:
            ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
        home: const AppInitializer(),
        onGenerateRoute: AppRouter.init,
      ),
    );
  }
}
