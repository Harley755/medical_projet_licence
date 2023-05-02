import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/dashboard/health_professional/utils/global_variables.dart';
import 'package:medical_projet/size_config.dart';

class ProfessionalNavigationBar extends StatefulWidget {
  const ProfessionalNavigationBar({super.key});

  @override
  State<ProfessionalNavigationBar> createState() =>
      _ProfessionalNavigationBarState();
}

class _ProfessionalNavigationBarState extends State<ProfessionalNavigationBar> {
  int _selectedIndex = 0;
  int badge = 0;
  final padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12);
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
        children: professionalScreenItems,
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
                  text: 'Obtenir',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: kPrimaryColor,
                  iconColor: Colors.black,
                  textColor: kPrimaryColor,
                  backgroundColor: selectTabBg,
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.medicalClinic,
                  text: 'Info médicales',
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
                      'https://wallpapers-clan.com/wp-content/uploads/2022/07/anime-default-pfp-2.jpg',
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
