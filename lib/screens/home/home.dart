import 'package:digital_card_app/constants.dart';
import 'package:digital_card_app/provider/theme.dart';
import 'package:digital_card_app/screens/create_card.dart';
import 'package:digital_card_app/screens/home/contacts.dart';
import 'package:digital_card_app/screens/home/profile.dart';
import 'package:digital_card_app/screens/home/settings/settings.dart';
import 'package:digital_card_app/screens/tapea_card.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;

  int _page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: SafeArea(
          child: Image.asset(
            "assets/image/tapea.png",
            height: 48,
          ),
        ),
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
      ),
      body: PageView(
        children: [
          const Contacts(),
          TapeaCard(),
          Profile(uid: FirebaseAuthAPI.getCurrentUser(context)!.uid),
          const AppSettings(),
        ],
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: getColorbyTheme(),
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
          onTap: onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: getIcon(0),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: getIcon(1),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: getIcon(2),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: getIcon(3),
              label: "",
            )
          ],
        ),
      ),
    );
  }

  Icon getIcon(int page) {
    if (page == 0) {
      if (_page == page) {
        return Icon(Icons.contacts, color: getColorbyTheme());
      }
      return Icon(Icons.contacts_outlined, color: getColorbyTheme());
    }
    if (page == 1) {
      if (_page == page) {
        return Icon(Icons.contact_mail, color: getColorbyTheme());
      }
      return Icon(Icons.contact_mail_outlined, color: getColorbyTheme());
    }
    if (page == 2) {
      if (_page == page) {
        return Icon(Icons.person, color: getColorbyTheme());
      }
      return Icon(Icons.person_outlined, color: getColorbyTheme());
    }
    if (page == 3) {
      if (_page == page) {
        return Icon(Icons.settings, color: getColorbyTheme());
      }
      return Icon(Icons.settings_outlined, color: getColorbyTheme());
    }
    throw ("Invalid page");
  }

  Color getColorbyTheme() {
    final ThemeProvider provider = Provider.of(context);
    if (provider.isDarkMode) {
      return Colors.white;
    }
    return Colors.black;
  }

  void onItemTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
