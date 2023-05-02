import 'package:flutter/material.dart';

class ProfessionalGetPage extends StatefulWidget {
  const ProfessionalGetPage({super.key});

  @override
  State<ProfessionalGetPage> createState() => _ProfessionalGetPageState();
}

class _ProfessionalGetPageState extends State<ProfessionalGetPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Professional Get Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
    ));
  }
}
