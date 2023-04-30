import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/components/body.dart';
import 'package:medical_projet/size_config.dart';

class InfoSignUpScreen extends StatelessWidget {
  static String routeName = "/info_sign_up";

  const InfoSignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: BodyInfoSignUp(),
    );
  }
}
