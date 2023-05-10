import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/user/utils/global_variables.dart';
import 'package:medical_projet/size_config.dart';

class UserNavigationBar extends StatefulWidget {
  const UserNavigationBar({super.key});

  @override
  State<UserNavigationBar> createState() => _UserNavigationBarState();
}

class _UserNavigationBarState extends State<UserNavigationBar> {
  late PageController pageController;

  late String _profileImageUrl;

  @override
  void initState() {
    pageController = PageController();
    _profileImageUrl =
        "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg";
    // Chargement de l'image de profil à partir de Firebase Storage si elle existe.

    final user = FirebaseAuth.instance.currentUser;
    final fileName = user!.uid;
    final storageRef =
        FirebaseStorage.instance.ref().child('avatars/$fileName');
    storageRef.getDownloadURL().then((url) {
      setState(() {
        _profileImageUrl = url;
      });
    }).catchError((error) {
      print(error);
    });
    super.initState();
  }

  int _selectedIndex = 0;
  int badge = 0;
  final padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  double gap = 10;

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
                  text: 'Acceuil',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: kPrimaryColor,
                  iconColor: Colors.black,
                  textColor: kPrimaryColor,
                  backgroundColor: selectTabBg,
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.medicalNotes,
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
                  leading: FutureBuilder<String>(
                    future: Future.value(_profileImageUrl),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        print(snapshot.hasError);
                      }
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 12.0,
                          backgroundImage: NetworkImage(snapshot.data!),
                        );
                      } else {
                        return const CircleAvatar(
                          radius: 12.0,
                          backgroundImage: NetworkImage(
                            "https://64.media.tumblr.com/eb8013a5fded5dcb55eee5ba2e48c86c/012efcaf904bfd8e-89/s640x960/cbb4836ddab081451c45286f7f9ab278f99f59f7.pnj",
                          ),
                        );
                      }
                    },
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
