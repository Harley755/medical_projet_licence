import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/profile/components/admin_profile_menu.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/profile/components/admin_sub_profile_menu.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({super.key});

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  bool isClicked = false;
  bool isClickedToogle = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // MES INFORMATIONS D'IDENTITE

          // SECURITE DROPDOWN
          AdminProfileMenu(
            bottomPadding: 5,
            clickToogle: isClickedToogle,
            text: "Sécurité",
            icon: "assets/icons/Lock.svg",
            press: () {
              setState(() {
                isClicked = !isClicked;
                isClickedToogle = !isClickedToogle;
              });
            },
          ),
          // DROPDOWN CHILD
          isClicked
              ? Column(
                  children: [
                    AdminSubProfileMenu(
                      text: "Changer d'adresse email",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                    AdminSubProfileMenu(
                      text: "Ajouter des empreintes",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                    AdminSubProfileMenu(
                      text: "Changer de mot de passe",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                    AdminSubProfileMenu(
                      downPadding: 14,
                      text: "Changer de numéro de téléphone",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                  ],
                )
              : Container(),

          // TOOGLE DARK/WHITE MODE AND CHANGE LANGUAGE
          AdminProfileMenu(
            text: "Parametre",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),

          // LOG OUT
          AdminProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/Log out.svg",
            press: () => UserAuthMethods().logOut(),
          ),
        ],
      ),
    );
  }
}
