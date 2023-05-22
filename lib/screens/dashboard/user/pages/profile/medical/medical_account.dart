import "package:flutter/material.dart";
import "package:medical_projet/screens/auth/informative_account/sign_up/sign_up_screen.dart";
import "package:medical_projet/screens/dashboard/health_professional/pages/profile/associated_account/components/professional_associated_body.dart";
import "package:medical_projet/screens/dashboard/user/pages/profile/associated_account/components/associated_account_body.dart";
import "package:medical_projet/screens/dashboard/user/pages/profile/associated_account/new_signup_account/new_signup.dart";
import "package:medical_projet/screens/dashboard/user/pages/profile/medical/components/medical_account_body.dart";
import "package:medical_projet/size_config.dart";
import "package:medical_projet/utils/constants.dart";

class MedicalAccount extends StatefulWidget {
  static String routeName = "/user/medical-associated-account";
  const MedicalAccount({super.key});

  @override
  State<MedicalAccount> createState() => _MedicalAccountState();
}

class _MedicalAccountState extends State<MedicalAccount> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mon compte medical",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const MedicalAccountBody(),
    );
  }
}
