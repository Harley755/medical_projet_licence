import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/dashboard/user/utils/global_variables.dart';
import 'package:medical_projet/size_config.dart';
import 'package:badges/badges.dart' as badges;

class AdminNavigationBar extends StatefulWidget {
  const AdminNavigationBar({super.key});

  @override
  State<AdminNavigationBar> createState() => _AdminNavigationBarState();
}

class _AdminNavigationBarState extends State<AdminNavigationBar> {
  int _selectedIndex = 0;
  int badge = 2;
  final padding = const EdgeInsets.symmetric(
    horizontal: 18,
    vertical: 12,
  );
  double gap = 10;

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
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
        children: userScreenItems,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
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
                  icon: LineIcons.home,
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
                  icon: LineIcons.bell,
                  text: "Notifications",
                  leading: _selectedIndex == 1 || badge == 0
                      ? null
                      : badges.Badge(
                          position:
                              badges.BadgePosition.topEnd(top: -12, end: -12),
                          badgeContent: Text(
                            badge.toString(),
                            style: TextStyle(color: Colors.red.shade900),
                          ),
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: Colors.red.shade100,
                            elevation: 0,
                          ),
                          child: Icon(
                            LineIcons.bell,
                            color: _selectedIndex == 1
                                ? Colors.pink
                                : Colors.black,
                          ),
                        ),
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: kPrimaryColor,
                  iconColor: Colors.black,
                  textColor: kPrimaryColor,
                  backgroundColor: selectTabBg,
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.user,
                  leading: const CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/08/2a/1b/082a1bb32a158d7270582c044fca7bfd.jpg',
                    ),
                  ),
                  text: 'Profile',
                )
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
