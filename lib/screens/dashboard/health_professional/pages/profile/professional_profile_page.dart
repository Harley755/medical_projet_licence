import 'package:flutter/material.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/components/professional_body.dart';

class ProfessionalProfilePage extends StatefulWidget {
  static String routeName = "/professional/profile";
  const ProfessionalProfilePage({super.key});

  @override
  State<ProfessionalProfilePage> createState() =>
      _ProfessionalProfilePageState();
}

class _ProfessionalProfilePageState extends State<ProfessionalProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mon Profile",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const ProfessionalBody(),
    );
  }
}
