import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/home/components/body_user_home_page.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Conseils et astuces",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const BodyUserHomePage(),
    );
  }
}
