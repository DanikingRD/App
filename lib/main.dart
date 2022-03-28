import 'package:digital_card_app/provider/preferences_provider.dart';
import 'package:digital_card_app/provider/theme_provider.dart';
import 'package:digital_card_app/provider/user_provider.dart';
import 'package:digital_card_app/screens/home/home_screen_layout.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/screens/welcome/welcome_screen_layout.dart';
import 'package:digital_card_app/util.dart';
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
    return FirebaseAuthProvider(builder: (ctx, widget) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(),
          ),
        ],
        child: Tapea(loggedIn: FirebaseAuthAPI.getCurrentUser(ctx) != null),
      );
    });
  }
}

class Tapea extends StatelessWidget { 
  final bool loggedIn;
  const Tapea({Key? key, required this.loggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tapea',
      theme: TapeaThemes.lightTheme,
      darkTheme: TapeaThemes.darkTheme,
      themeMode: loggedIn
          ? Provider.of<ThemeProvider>(context).themeMode
          : ThemeMode.system,
      home: const AuthManager(
        root: WelcomeScreenLayout(),
        home: HomeScreenLayout(),
      ),
      onGenerateRoute: AppRouter.init,
    );
  }
}
