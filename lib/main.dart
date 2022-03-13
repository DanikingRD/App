import 'package:digital_card_app/provider/theme.dart';
import 'package:digital_card_app/screens/home/home.dart';
import 'package:digital_card_app/screens/login.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const AppInitializer());
}

class AppInitializer extends StatelessWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseAuthProvider(
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const Tapea(),
      ),
    );
  }
}

class Tapea extends StatelessWidget {
  const Tapea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tapea',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      home: const AuthManager(
        login: LoginScreen(),
        home: HomeScreen(),
      ),
      onGenerateRoute: AppRouter.init,
    );
  }
}
