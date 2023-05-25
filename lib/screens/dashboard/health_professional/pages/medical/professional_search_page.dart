import 'package:flutter/material.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/body.dart';
import 'package:medical_projet/size_config.dart';

class ProfessionalSearchPage extends StatefulWidget {
  static String routeName = "/professional/search";

  const ProfessionalSearchPage({super.key});

  @override
  State<ProfessionalSearchPage> createState() => _ProfessionalSearchState();
}

class _ProfessionalSearchState extends State<ProfessionalSearchPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Patients",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const BodyProfessionalSearch(),
    );
  }
}
