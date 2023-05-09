import 'package:flutter/material.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/components/body.dart';
import 'package:medical_projet/size_config.dart';

class UserMedicalPage extends StatefulWidget {
  static String routeName = "/user/info_medicales";

  const UserMedicalPage({super.key});

  @override
  State<UserMedicalPage> createState() => _UseMedicalPageState();
}

class _UseMedicalPageState extends State<UserMedicalPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Informations Médicales",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const BodyUserMedical(),
    );
  }
}
