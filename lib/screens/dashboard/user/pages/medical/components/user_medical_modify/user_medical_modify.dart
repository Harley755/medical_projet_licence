import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/components/user_medical_modify/components/body.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';

class UserMedicalModify extends StatefulWidget {
  static String routeName = "/user/info_medicales/modify";

  const UserMedicalModify({super.key});

  @override
  State<UserMedicalModify> createState() => _UseMedicalPageState();
}

class _UseMedicalPageState extends State<UserMedicalModify> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modifier Informations Médicales",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const BodyUserMedicalModify(),
    );
  }
}
