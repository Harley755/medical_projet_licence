import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/auth/sign_up/components/admin_sign_up_form.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class BodyAdminSignUp extends StatelessWidget {
  const BodyAdminSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Créer un compte Admin", style: headingStyle),
              const Text(
                "Veuillez remplir tous les champs",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              const AdminSignUpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              // TRANSITIONING TO SIGNING UP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous avez déja un compte ? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        InfoSignInScreen.routeName,
                      );
                    },
                    child: RobotoFont(
                      size: getProportionateScreenWidth(16),
                      title: "Connectez-vous",
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text("Vous avez déja un compte médical ? "),
              //     SizedBox(height: getProportionateScreenHeight(5.0)),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.pushNamed(
              //           context,
              //           MedicalSignInScreen.routeName,
              //         );
              //       },
              //       child: RobotoFont(
              //         size: getProportionateScreenWidth(16),
              //         title: "Connectez-vous",
              //         fontWeight: FontWeight.bold,
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(height: SizeConfig.screenHeight * 0.048),
              RobotoFont(
                title:
                    'En continuant, vous confirmez que vous acceptez\nnos Termes and Conditions',
                size: getProportionateScreenWidth(14),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
