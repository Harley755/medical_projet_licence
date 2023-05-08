import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_modfy_profile/user_profile_identity_modify.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/components/body.dart';
import 'package:medical_projet/size_config.dart';

class UserProfileIdentity extends StatefulWidget {
  static String routeName = "/user/profile/identity";

  const UserProfileIdentity({super.key});

  @override
  State<UserProfileIdentity> createState() => _UserProfileIdentityState();
}

class _UserProfileIdentityState extends State<UserProfileIdentity> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Informations Identité",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const BodyUserIdentityReadOnly(),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 60,
                color: Colors.black.withOpacity(.4),
                offset: const Offset(0, 25),
              )
            ],
          ),
          child: DefaultButton(
            text: "Modifier",
            press: () {
              Navigator.pushNamed(context, UserProfileIdentityModify.routeName);
            },
          ),
        ),
      ),
    );
  }
}
