import 'package:flutter/material.dart';

class UserMedicalPage extends StatefulWidget {
  const UserMedicalPage({super.key});

  @override
  State<UserMedicalPage> createState() => _UseMedicalPageState();
}

class _UseMedicalPageState extends State<UserMedicalPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Médical Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
    ));
  }
}
