import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/security/change_password/components/user_change_password_body.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UserChangePassword extends StatefulWidget {
  static String routeName = "user/security/change-password";
  const UserChangePassword({super.key});

  @override
  State<UserChangePassword> createState() => _UserChangePasswordState();
}

class _UserChangePasswordState extends State<UserChangePassword> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Changer mon mot de passe",
          style: TextStyle(color: kSecondaryColor),
        ),
      ),
      body: const UserChangePasswordBody(),
    );
  }
}
