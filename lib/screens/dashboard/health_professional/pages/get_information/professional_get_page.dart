import 'package:flutter/material.dart';

import 'package:medical_projet/screens/dashboard/health_professional/pages/get_information/components/professional_get_way.dart';

class ProfessionalGetPage extends StatefulWidget {
  const ProfessionalGetPage({super.key});

  @override
  State<ProfessionalGetPage> createState() => _ProfessionalGetPageState();
}

class _ProfessionalGetPageState extends State<ProfessionalGetPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Le saviez-vous ?",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: const ProfessionalGetWay(),
      ),
    );
  }
}
