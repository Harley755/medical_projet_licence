import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/associated_account/new_signup_account/components/new_signup_form.dart';
import 'package:medical_projet/size_config.dart';

class BodyNewSignUp extends StatelessWidget {
  const BodyNewSignUp({super.key});

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
              SizedBox(height: SizeConfig.screenHeight * 0.04), // 5%
              const NewSignUpForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              // TRANSITIONING TO SIGNING UP
              SizedBox(height: SizeConfig.screenHeight * 0.02),

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
