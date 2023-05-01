import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/components/profile_pic.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_profile_identity.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Mes informations d'identité",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(context, UserProfileIdentity.routeName),
            },
          ),
          ProfileMenu(
            text: "Comptes Associés",
            icon: "assets/icons/add_user.svg",
            width: 28,
            press: () => {},
          ),
          ProfileMenu(
            text: "Parametre",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Demande d'aide",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
