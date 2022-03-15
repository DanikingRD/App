import 'package:digital_card_app/provider/home.dart';
import 'package:digital_card_app/screens/create_card.dart';
import 'package:digital_card_app/screens/home/bottom_navigation.dart';
import 'package:digital_card_app/screens/home/contacts.dart';
import 'package:digital_card_app/screens/home/profile.dart';
import 'package:digital_card_app/screens/home/settings/settings.dart';
import 'package:digital_card_app/screens/tapea_card.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late final String uid;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    uid = FirebaseAuthAPI.getCurrentUser(context)!.uid;
    final state = HomeProvider(uid);
    return ChangeNotifierProvider(
      create: (_) => state,
      child: FutureBuilder(
        future: state.init(),
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return buildHome(context);
          }
        },
      ),
    );
  }

  Widget buildHome(BuildContext context) {
    final homeState = Provider.of<HomeProvider>(context);
    final theme = Theme.of(context);
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
          Profile(uid: uid),
          const AppSettings(),
        ],
      ),
      bottomNavigationBar: HomeButtonNavigation(
        onTap: _pageController.jumpToPage,
      ),
    );
  }
}
