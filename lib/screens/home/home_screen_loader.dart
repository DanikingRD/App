import 'package:digital_card_app/provider/card_provider.dart';
import 'package:digital_card_app/provider/user_provider.dart';
import 'package:digital_card_app/screens/home/contacts.dart';
import 'package:digital_card_app/screens/home/settings/app_settings.dart';
import 'package:digital_card_app/screens/router.dart';
import 'package:digital_card_app/screens/home/tapea_card.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class HomeScreenLoader extends StatefulWidget {
  const HomeScreenLoader({Key? key}) : super(key: key);

  @override
  State<HomeScreenLoader> createState() => _HomeScreenLoaderState();
}

class _HomeScreenLoaderState extends State<HomeScreenLoader> {
  final PageController _pageController = PageController();
  bool loading = false;

  int _page = 0;

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  void loadAll() async {
    setState(() {
      loading = true;
    });
    UserProvider? user;
    try {
      print("loading user");
      user = await loadUser();
    } on Exception catch (_) {
      print("got an exception");
      Navigator.pushReplacementNamed(context, AppRouter.loginPage);
    }
    if (user != null) {
      await loadCard(user);
    }
    setState(() {
      loading = false;
    });
  }

  Future<UserProvider> loadUser() async {
    final UserProvider user = Provider.of<UserProvider>(context, listen: false);
    await user.update(context);
    return user;
  }

  Future<void> loadCard(UserProvider userProvider) async {
    final CardProvider card = Provider.of<CardProvider>(context, listen: false);
    final title = userProvider.getUser.defaultProfile;
    card.update(title, context);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.createCardPage);
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
        ],
        backgroundColor: Colors.white,
        title: SafeArea(
          child: Image.asset(
            "assets/image/tapea.png",
            height: 48,
          ),
        ),
      ),
      body: PageView(
        onPageChanged: onPageChanged,
        controller: _pageController,
        children: const [
          Contacts(),
          TapeaCardScreen(),
          AppSettings(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1.4,
              offset: Offset(
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
    const color = Colors.black;
    if (page == 0) {
      if (_page == page) {
        return const Icon(Icons.contacts, color: color);
      }
      return const Icon(Icons.contacts_outlined, color: color);
    }
    if (page == 1) {
      if (_page == page) {
        return const Icon(Icons.contact_mail, color: color);
      }
      return const Icon(Icons.contact_mail_outlined, color: color);
    }
    if (page == 2) {
      if (_page == page) {
        return const Icon(Icons.person, color: color);
      }
      return const Icon(Icons.person_outlined, color: color);
    }
    if (page == 3) {
      if (_page == page) {
        return const Icon(Icons.settings, color: color);
      }
      return const Icon(Icons.settings_outlined, color: color);
    }
    throw ("Invalid page");
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
