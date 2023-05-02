import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/components/professional_profile_pic.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/identity/professional_profile_identity.dart';

import 'professional_profile_menu.dart';

class ProfessionalBody extends StatelessWidget {
  const ProfessionalBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfessionalProfilePic(),
          const SizedBox(height: 20),
          ProfessionalProfileMenu(
            text: "Mes informations d'identité",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(
                  context, ProfessionalProfileIdentity.routeName),
            },
          ),
          ProfessionalProfileMenu(
            text: "Parametre",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfessionalProfileMenu(
            text: "Demande d'aide",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfessionalProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
