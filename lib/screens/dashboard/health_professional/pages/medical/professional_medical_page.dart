import 'package:flutter/material.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/body.dart';
import 'package:medical_projet/size_config.dart';

class ProfessionalMedicalPage extends StatefulWidget {
  static String routeName = "/user/info_medicales";

  const ProfessionalMedicalPage({super.key});

  @override
  State<ProfessionalMedicalPage> createState() => _UseMedicalPageState();
}

class _UseMedicalPageState extends State<ProfessionalMedicalPage> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes Informations Privées",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: BodyProfessionalMedical(formKey: formKey),
    );
  }
}
