import 'package:digital_card_app/handler/auth_handler.dart';
import 'package:digital_card_app/provider/user_provider.dart';
import 'package:digital_card_app/screens/login.dart';
import 'package:firebase_cloud_functions/auth.dart';
import 'package:firebase_cloud_functions/cloud_services.dart';
import 'package:firebase_cloud_functions/user/user.dart';
import 'package:firebase_cloud_functions/entry_point.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/routes.dart';

Future<void> main(List<String> args) async {
  await FirebaseCloudFunctions.init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  //TO-DO: Look at visual density

  @override
  Widget build(BuildContext context) {
    final authService = FirebaseCloudServices.authService;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tapea',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
        home: StreamBuilder(
          stream: authService.authListener(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const AuthEventHandler();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            // If we got here then the user hasn't been authenticated.
            return const LoginScreen();
          },
        ),
        onGenerateRoute: RouteGenerator.generate,
      ),
    );
  }
}
