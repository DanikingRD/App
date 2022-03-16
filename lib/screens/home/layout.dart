import 'package:digital_card_app/model/preferences.dart';
import 'package:digital_card_app/provider/home.dart';
import 'package:digital_card_app/provider/theme.dart';
import 'package:digital_card_app/screens/create_card.dart';
import 'package:digital_card_app/screens/home/bottom_navigation.dart';
import 'package:digital_card_app/screens/home/contacts.dart';
import 'package:digital_card_app/screens/home/profile.dart';
import 'package:digital_card_app/screens/home/settings/settings.dart';
import 'package:digital_card_app/screens/tapea_card.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class HomeScreenLayout extends StatelessWidget {
  HomeScreenLayout({Key? key}) : super(key: key);
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final preferences = context.watch<UserPreferences>();
    final localTheme = context.watch<ThemeProvider>();
    print("First run");
    print("Local Theme was ${localTheme.themeMode}");
    print("Prefence Theme was ${preferences.theme}");
    print("==============================================");
    if (localTheme.themeMode != preferences.themeMode) {
      localTheme.setMode(
        ThemeProvider.getThemeById(
          preferences.theme,
        ),
      );
    }
    print("Final: ");
    print("Local Theme was ${context.watch<ThemeProvider>().themeMode}");
    print("Prefence Theme was ${context.watch<UserPreferences>().themeMode}");
    return buildHome(context);
  }

  Widget buildHome(BuildContext context) {
    final homeState = Provider.of<HomeProvider>(context);
    final theme = Theme.of(context);
    // Don't ever try to call the streams providers here
    // It's too early
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateCardScreen(),
                ),
              );
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
        onPageChanged: homeState.nextPage,
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          const Contacts(),
          TapeaCard(),
          Profile(uid: FirebaseAuthAPI.getCurrentUser(context)!.uid),
          const AppSettings(),
        ],
      ),
      bottomNavigationBar: HomeButtonNavigation(
        onTap: _pageController.jumpToPage,
      ),
    );
  }
}
