import 'package:digital_card_app/model/card.dart';
import 'package:digital_card_app/model/preferences.dart';
import 'package:digital_card_app/provider/preferences_provider.dart';
import 'package:digital_card_app/provider/theme_provider.dart';
import 'package:digital_card_app/provider/user_provider.dart';
import 'package:digital_card_app/screens/home/contacts.dart';
import 'package:digital_card_app/screens/home/create_card.dart';
import 'package:digital_card_app/screens/home/settings/settings_layout.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/screens/home/tapea_card.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class HomeScreenLayout extends StatefulWidget {
  const HomeScreenLayout({Key? key}) : super(key: key);

  @override
  State<HomeScreenLayout> createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  final PageController _pageController = PageController();
  late TapeaCard? card;
  bool loading = false;

  int _page = 0;

  void syncThemeMode(final UserPreferences preferences) {
    final localTheme = context.read<ThemeProvider>();
    localTheme.setMode(preferences.themeMode);
  }

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  void loadAll() async {
    setState(() {
      loading = true;
    });
    await loadUser();
    await loadPreferences();
    setState(() {
      loading = false;
    });
  }

  loadUser() async {
    final UserProvider user = Provider.of<UserProvider>(context, listen: false);
    return await user.update(context);
  }

  loadPreferences() async {
    final ThemeProvider theme = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    final PreferencesProvider preferences = Provider.of<PreferencesProvider>(
      context,
      listen: false,
    );
    await preferences.update(context);
    theme.setMode(preferences.getPreferences.themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : buildHome(context);
  }

  Widget buildHome(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.createCardPage);
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
        ],
        backgroundColor: theme.scaffoldBackgroundColor,
        title: SafeArea(
          child: Image.asset(
            "assets/image/tapea.png",
            height: 48,
          ),
        ),
      ),
      body: PageView(
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          Contacts(),
          TapeaCardScreen(),
          AppSettings(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: getIconColorForTheme(context),
              blurRadius: 1.4,
              offset: const Offset(
                0.0,
                1.0,
              ),
            )
          ],
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: getIcon(context, 0),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: getIcon(context, 1),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: getIcon(context, 2),
              label: "",
            ),
          ],
          currentIndex: _page,
          onTap: navigationTapped,
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    _pageController.jumpToPage(page);
  }

  Icon getIcon(BuildContext ctx, int page) {
    final color = getIconColorForTheme(ctx);
    if (page == 0) {
      if (_page == page) {
        return Icon(Icons.contacts, color: color);
      }
      return Icon(Icons.contacts_outlined, color: color);
    }
    if (page == 1) {
      if (_page == page) {
        return Icon(Icons.contact_mail, color: color);
      }
      return Icon(Icons.contact_mail_outlined, color: color);
    }
    if (page == 2) {
      if (_page == page) {
        return Icon(Icons.person, color: color);
      }
      return Icon(Icons.person_outlined, color: color);
    }
    if (page == 3) {
      if (_page == page) {
        return Icon(Icons.settings, color: color);
      }
      return Icon(Icons.settings_outlined, color: color);
    }
    throw ("Invalid page");
  }

  Color getIconColorForTheme(BuildContext ctx) {
    final ThemeProvider provider = Provider.of<ThemeProvider>(ctx);
    if (provider.isDarkMode(context)) {
      return Colors.white;
    }
    return Colors.black;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
