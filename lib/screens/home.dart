import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_card_app/screens/create_card.dart';
import 'package:digital_card_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: SafeArea(child: Image.asset("assets/image/tapea.png", height: 48)),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CreateCardScreen()));
          }, icon: const Icon(Icons.add_box_outlined)),
        ],
      ),
      body: PageView(
        children: homeScreenTabs,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        backgroundColor: theme.primaryColorDark,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: getIconColor(theme, 0)),
            label: "test",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: getIconColor(theme, 1)),
            label: "test",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: getIconColor(theme, 2)),
            label: "test",
            backgroundColor: Colors.white,
          ),
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
