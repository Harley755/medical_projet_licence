import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/sign_in/components/account_sign_in_form.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/auth/auth_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_in/components/sign_in_form.dart';
import 'package:medical_projet/size_config.dart';

class AccountBodyInfoSignIn extends StatelessWidget {
  final String email;
  const AccountBodyInfoSignIn({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.1),

                // Text(
                //   "Bienvenue sur votre compte informatif",
                //   style: headingStyle,
                //   textAlign: TextAlign.center,
                // ),
                Text(
                  "Bienvenue sur votre compte",
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 64.0),

                // CIRCULAR WIDGET TO ACCEPT AND SHOW OUR SELECTED FILE
                AccountSignInForm(email: email),

                SizedBox(height: SizeConfig.screenHeight * 0.2),

                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Vous n'avez pas un compte informatif ? \n"),
                //     InkWell(
                //       onTap: () {
                //         Navigator.pushNamed(
                //           context,
                //           AuthScreen.routeName,
                //         );
                //       },
                //       child: RobotoFont(
                //         size: getProportionateScreenWidth(16),
                //         title: "Inscrivez-vous",
                //         fontWeight: FontWeight.bold,
                //       ),
                //     )
                //   ],
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous n'avez pas un compte ? \n"),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AuthScreen.routeName,
                        );
                      },
                      child: RobotoFont(
                        size: getProportionateScreenWidth(16),
                        title: "Inscrivez-vous",
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
