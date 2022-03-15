import 'package:digital_card_app/provider/home.dart';
import 'package:digital_card_app/provider/theme.dart';
import 'package:firebase_cloud_functions/firebase_cloud_functions.dart';
import 'package:flutter/material.dart';

class HomeButtonNavigation extends StatelessWidget {
  final Function(int)? onTap;

  const HomeButtonNavigation({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: getColorbyTheme(context),
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
        onTap: onTap,
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
          BottomNavigationBarItem(
            icon: getIcon(context, 3),
            label: "",
          )
        ],
      ),
    );
  }

  static Icon getIcon(BuildContext ctx, int page) {
    final activePage = Provider.of<HomeProvider>(ctx).page;
    final color = getColorbyTheme(ctx);
    if (page == 0) {
      if (activePage == page) {
        return Icon(Icons.contacts, color: color);
      }
      return Icon(Icons.contacts_outlined, color: color);
    }
    if (page == 1) {
      if (activePage == page) {
        return Icon(Icons.contact_mail, color: color);
      }
      return Icon(Icons.contact_mail_outlined, color: color);
    }
    if (page == 2) {
      if (activePage == page) {
        return Icon(Icons.person, color: color);
      }
      return Icon(Icons.person_outlined, color: color);
    }
    if (page == 3) {
      if (activePage == page) {
        return Icon(Icons.settings, color: color);
      }
      return Icon(Icons.settings_outlined, color: color);
    }
    throw ("Invalid page");
  }

  static Color getColorbyTheme(BuildContext ctx) {
    final ThemeProvider provider = Provider.of<ThemeProvider>(ctx);
    if (provider.isDarkMode) {
      return Colors.white;
    }
    return Colors.black;
  }
}
