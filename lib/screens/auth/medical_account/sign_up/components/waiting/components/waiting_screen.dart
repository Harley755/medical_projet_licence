import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/auth/auth_screen.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class BuildWaitingScreen extends StatelessWidget {
  const BuildWaitingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * .30,
                ),
                const CircularProgressIndicator(color: kPrimaryColor),
                const SizedBox(height: 16.0),
                const RobotoFont(
                  title:
                      "Veuillez patienter\nVotre demande est en cours de traitement...",
                  size: 20.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25.0),
                DefaultButton(
                  text: "Deconnexion",
                  press: () async {
                    await UserAuthMethods().logOut();
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
          ),
        ),
      ),
    );
  }
}
