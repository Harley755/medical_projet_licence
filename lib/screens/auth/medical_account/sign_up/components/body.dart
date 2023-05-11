import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/size_config.dart';

import 'sign_up_form.dart';

class BodyMedicalSignUp extends StatelessWidget {
  const BodyMedicalSignUp({super.key});

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
              SizedBox(height: SizeConfig.screenHeight * 0.03), // 6%
              const SignUpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              // TRANSITIONING TO SIGNING UP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous avez déja un compte ? "),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MedicalSignInScreen.routeName,
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
              SizedBox(height: SizeConfig.screenHeight * 0.03),

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
