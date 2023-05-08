import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/components/profile_pic.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/components/sub_profile_menu.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_profile_identity.dart';

import 'profile_menu.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isClicked = false;
  bool isClickedToogle = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          // MES INFORMATIONS D'IDENTITE
          ProfileMenu(
            text: "Mes informations d'identité",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.pushNamed(
              context,
              UserProfileIdentity.routeName,
            ),
          ),

          // SECURITE DROPDOWN
          ProfileMenu(
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
                    SubProfileMenu(
                      text: "Changer d'adresse email",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                    SubProfileMenu(
                      text: "Ajouter des empreintes",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                    SubProfileMenu(
                      text: "Changer de mot de passe",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                    SubProfileMenu(
                      downPadding: 14,
                      text: "Changer de numéro de téléphone",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                  ],
                )
              : Container(),

          // CREATE ACCOUNT FOR CHILDREN
          ProfileMenu(
            text: "Comptes Associés",
            icon: "assets/icons/add_user.svg",
            width: 28,
            press: () => {},
          ),

          // TOOGLE DARK/WHITE MODE AND CHANGE LANGUAGE
          ProfileMenu(
            text: "Parametre",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),

          /// WRITE TO CENTER FOR FEEDBACK
          ProfileMenu(
            text: "Demande d'aide",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),

          // LOG OUT
          ProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/Log out.svg",
            press: () async {
              await UserMethods().signOut();
            },
          ),
        ],
      ),
    );
  }
}
