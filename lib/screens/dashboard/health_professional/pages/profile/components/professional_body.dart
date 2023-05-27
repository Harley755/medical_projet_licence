import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/auth/auth_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/sign_up_screen.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/associated_account/associated_account.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/components/professional_profile_menu.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/components/professional_profile_pic.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/components/professional_sub_profile_menu.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/identity/professional_profile_identity.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/security/change_password/user_change_password.dart';

class ProfessionalBody extends StatefulWidget {
  const ProfessionalBody({super.key});

  @override
  State<ProfessionalBody> createState() => _ProfessionalBodyState();
}

class _ProfessionalBodyState extends State<ProfessionalBody> {
  bool isClicked = false;
  bool isClickedToogle = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfessionalProfilePic(),
          const SizedBox(height: 20),
          // MES INFORMATIONS D'IDENTITE
          ProfessionalProfileMenu(
            text: "Mes informations",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.pushNamed(
              context,
              ProfessionalProfileIdentity.routeName,
            ),
          ),

          // SECURITE DROPDOWN
          ProfessionalProfileMenu(
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

          // // USER ACCOUNT
          // ProfessionalProfileMenu(
          //   text: "Compte Associé",
          //   icon: "assets/icons/User Icon.svg",
          //   press: () => Navigator.pushNamed(
          //     context,
          //     ProfessionalAssociatedAccount.routeName,
          //   ),
          // ),

          // DROPDOWN CHILD
          isClicked
              ? Column(
                  children: [
                    ProfessionalSubProfileMenu(
                      text: "Changer d'adresse email",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                    ProfessionalSubProfileMenu(
                      text: "Changer de mot de passe",
                      icon: "assets/icons/Lock.svg",
                      press: () => Navigator.pushNamed(
                        context,
                        UserChangePassword.routeName,
                      ),
                    ),
                    ProfessionalSubProfileMenu(
                      downPadding: 14,
                      text: "Changer de numéro de téléphone",
                      icon: "assets/icons/Lock.svg",
                      press: () => {},
                    ),
                  ],
                )
              : Container(),

          // TOOGLE DARK/WHITE MODE AND CHANGE LANGUAGE
          ProfessionalProfileMenu(
            text: "Parametre",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),

          /// WRITE TO CENTER FOR FEEDBACK
          // ProfessionalProfileMenu(
          //   text: "Demande d'aide",
          //   icon: "assets/icons/Question mark.svg",
          //   press: () {},
          // ),

          // LOG OUT
          ProfessionalProfileMenu(
            text: "Déconnexion",
            icon: "assets/icons/Log out.svg",
            press: () async {
              await UserAuthMethods().signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
