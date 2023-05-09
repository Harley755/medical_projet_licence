import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_modfy_profile/components/body.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';

class UserProfileIdentityModify extends StatefulWidget {
  static String routeName = "/user/profile-modify/identity";

  const UserProfileIdentityModify({super.key});

  @override
  State<UserProfileIdentityModify> createState() =>
      _UserProfileIdentityModifyState();
}

class _UserProfileIdentityModifyState extends State<UserProfileIdentityModify> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modifier informations Identité",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const BodyUserIdentity(),
    );
  }
}
