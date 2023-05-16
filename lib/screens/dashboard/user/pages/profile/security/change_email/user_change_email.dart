import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/security/change_email/components/user_change_email_body.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UserChangeEmail extends StatefulWidget {
  static String routeName = "user/security/change-email";
  const UserChangeEmail({super.key});

  @override
  State<UserChangeEmail> createState() => _UserChangeEmailState();
}

class _UserChangeEmailState extends State<UserChangeEmail> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Changer mon adresse email",
          style: TextStyle(color: kSecondaryColor),
        ),
      ),
      body: const UserChangeEmailBody(),
    );
  }
}
