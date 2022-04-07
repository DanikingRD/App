import 'package:digital_card_app/provider/card_provider.dart';
import 'package:digital_card_app/provider/user_provider.dart';
import 'package:digital_card_app/screens/home/home_screen_loader.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/screens/welcome/welcome_screen_layout.dart';
import 'package:digital_card_app/util.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

Future<void> main(List<String> args) async {  
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
      print('[${record.time.toString().substring(11, 19)}] [${record.loggerName}/${record.level.name}]: ${record.message}');
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppInitializer());
}

class AppInitializer extends StatelessWidget {
  const AppInitializer({Key? key}) : super(key: key);

  static final _log = Logger((AppInitializer).toString());

  @override
  Widget build(BuildContext context) {
    return FirebaseAuthProvider(
      builder: (ctx, widget) { 
        _log.fine("Loading Tapea 1.0.0");
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
            ChangeNotifierProvider(create: (_) => CardProvider())
          ],
          child: Tapea(loggedIn: FirebaseAuthAPI.getCurrentUser(ctx) != null),
        );
      },
    );
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
      themeMode: loggedIn ? ThemeMode.system : ThemeMode.light,
      home: const AuthManager(
        root: WelcomeScreenLayout(),
        home: HomeScreenLoader(),
      ),
      onGenerateRoute: AppRouter.init,
    );
  }
}
