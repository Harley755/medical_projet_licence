import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_in/components/body.dart';
import 'package:medical_projet/size_config.dart';

class MedicalSignInScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const MedicalSignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            size: getProportionateScreenWidth(30),
          ),
        ),
      ),
      body: const BodyMedicalSignIn(),
    );
  }
}
