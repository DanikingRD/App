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
        backgroundColor: theme.primaryColorDark,
        titleSpacing: 16.0,
        title:
            SafeArea(child: Image.asset("assets/image/tapea.png", height: 48)),
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: onItemTapped,
        backgroundColor: theme.primaryColorDark,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts_sharp,
              color: getIconColor(theme, 0),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.quick_contacts_mail,
              color: getIconColor(theme, 1),
            ),
            label: "",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_rounded,
              color: getIconColor(theme, 2),
            ),
            label: "",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: getIconColor(theme, 3),
            ),
            label: '',
          )
        ],
      ),
    );
  }

  Color getIconColor(ThemeData data, int page) {
    return page == _page ? Colors.white : data.primaryColorLight;
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
