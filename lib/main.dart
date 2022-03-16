import 'package:digital_card_app/model/preferences.dart';
import 'package:digital_card_app/model/user.dart';
import 'package:digital_card_app/provider/home.dart';
import 'package:digital_card_app/provider/theme.dart';
import 'package:digital_card_app/screens/home/layout.dart';
import 'package:digital_card_app/screens/login.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/util.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const AppInitializer());
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  late final TapeaUser? user;
  late final UserPreferences? preferences;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    setInitialData();
  }

  void setInitialData() async {
    setState(() {
      _loading = true;
    });

    user = await initUser(context);
    preferences = await initPreferences(context);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_loading);
    return FirebaseAuthProvider(
      builder: (ctx, widget) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => HomeProvider(),
            ),
            StreamProvider<TapeaUser?>(
              create: (_) => streamUser(
                FirebaseAuthAPI.getCurrentUser(ctx)!.uid,
              ),
              initialData: user,
            ),
            StreamProvider<UserPreferences?>(
                create: (_) => streamPreferences(
                      FirebaseAuthAPI.getCurrentUser(ctx)!.uid,
                    ),
                initialData: preferences)
          ],
          child: const Tapea(),
        );
      },
    );
  }

  Future<TapeaUser?> initUser(BuildContext context) async {
    final User? user = FirebaseAuthAPI.getCurrentUser(context);
    if (user != null) {
      final json = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      final TapeaUser userModel = TapeaUser(
        uid: user.uid,
        email: user.email!,
        username: json.data()!["username"],
        avatarURL: json.data()!["avatarURL"],
      );
      return userModel;
    } else {
      return null;
    }
  }

  Future<UserPreferences?> initPreferences(BuildContext context) async {
    final User? user = FirebaseAuthAPI.getCurrentUser(context);
    if (user != null) {
      final json = await FirebaseFirestore.instance
          .collection("preferences")
          .doc(user.uid)
          .get();
      final UserPreferences preferences = UserPreferences(
        uid: user.uid,
        theme: json.data()![FirestoreJsonKeys.theme],
      );
      return preferences;
    } else {
      return null;
    }
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
      home: AuthManager(
        login: LoginScreen(),
        home: HomeScreenLayout(),
      ),
      onGenerateRoute: AppRouter.init,
    );
  }
}

Stream<UserPreferences> streamPreferences(String id) {
  return FirebaseFirestore.instance
      .collection("preferences")
      .doc(id)
      .snapshots()
      .map((event) => UserPreferences.fromJson(event.data()!));
}

Stream<TapeaUser> streamUser(String id) {
  return FirebaseFirestore.instance
      .collection("users")
      .doc(id)
      .snapshots()
      .map((event) => TapeaUser.fromJson(event.data()!));
}
