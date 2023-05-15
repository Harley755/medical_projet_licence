import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/identity/professional_modfy_profile/components/body_professional_identite.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';

class ProfessionalModifyProfile extends StatefulWidget {
  static String routeName = "/professional/profile-modify/identity";

  const ProfessionalModifyProfile({super.key});

  @override
  State<ProfessionalModifyProfile> createState() =>
      _ProfessionalModifyProfileState();
}

class _ProfessionalModifyProfileState extends State<ProfessionalModifyProfile> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modifier informations",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const ProfessionalBodyIdentity(),
    );
  }
}
