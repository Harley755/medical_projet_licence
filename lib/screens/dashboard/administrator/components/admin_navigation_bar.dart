import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medical_projet/services/notification/notification_service.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/administrator/utils/global_variables.dart';
import 'package:medical_projet/size_config.dart';
import 'package:badges/badges.dart' as badges;

class AdminNavigationBar extends StatefulWidget {
  const AdminNavigationBar({super.key});

  @override
  State<AdminNavigationBar> createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  User? user = FirebaseAuth.instance.currentUser;
  String token = "";

  int _selectedIndex = 0;
  int badge = 2;
  int badgeNotifs = 2;
  int badgeMessenger = 2;
  final padding = const EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 12,
  );
  double gap = 10;

  late PageController pageController;

  @override
  void initState() {
    // ADD DEVICE TOKEN
    initializeAndSaveToken();
    log("TOKEN MIS A JOUR AU NIVEAU DE DASHBOARD ADMIN");
    pageController = PageController();
    super.initState();
  }

  initializeAndSaveToken() async {
    String newToken = await NotificationServices().getToken();
    setState(() {
      token = newToken;
    });

    log("TOKEN tok : $token");
    NotificationServices().updateToken(
      collection: 'adminToken',
      doc: user!.uid,
      token: token,
    );
    log("TOKEN tok à mettre à jour: $token");
  }

  void navigatorTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _selectedIndex = page;
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (value) => onPageChanged(value),
        children: adminScreenItems,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 60,
                color: Colors.black.withOpacity(.4),
                offset: const Offset(0, 25),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
            child: GNav(
              tabs: [
                GButton(
                  gap: gap,
                  iconActiveColor: kPrimaryColor,
                  iconColor: Colors.black,
                  textColor: kPrimaryColor,
                  backgroundColor: selectTabBg,
                  iconSize: 24,
                  padding: padding,
                  icon: Icons.auto_graph_outlined,
                  text: 'Statistics',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: kPrimaryColor,
                  iconColor: Colors.black,
                  textColor: kPrimaryColor,
                  backgroundColor: selectTabBg,
                  iconSize: 24,
                  padding: padding,
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: kPrimaryColor,
                  iconColor: Colors.black,
                  textColor: kPrimaryColor,
                  backgroundColor: selectTabBg,
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.bell,
                  leading: _selectedIndex == 3 || badgeNotifs == 0
                      ? null
                      : badges.Badge(
                          position:
                              badges.BadgePosition.topEnd(top: -12, end: -12),
                          badgeContent: Text(
                            badgeNotifs.toString(),
                            style: TextStyle(color: Colors.red.shade900),
                          ),
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: Colors.red.shade100,
                            elevation: 0,
                          ),
                          child: Icon(
                            LineIcons.bell,
                            color: _selectedIndex == 4
                                ? Colors.pink
                                : Colors.black,
                          ),
                        ),
                  text: "Notifications",
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: navigatorTapped,
            ),
          ),
        ),
      ),
    );
  }
}
