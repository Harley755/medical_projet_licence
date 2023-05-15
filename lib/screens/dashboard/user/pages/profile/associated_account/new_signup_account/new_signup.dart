import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/components/body.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/associated_account/new_signup_account/components/body_new_signup.dart';
import 'package:medical_projet/size_config.dart';

class NewSignUp extends StatelessWidget {
  static String routeName = "user/new-sign-up/";

  const NewSignUp({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: const BodyNewSignUp(),
    );
  }
}
