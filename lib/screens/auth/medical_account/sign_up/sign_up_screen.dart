import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/components/body.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/body.dart';
import 'package:medical_projet/size_config.dart';

class MedicalSignUpScreen extends StatelessWidget {
  static String routeName = "/medical_sign_up";
  const MedicalSignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: BodyMedicalSignUp(),
    );
  }
}
