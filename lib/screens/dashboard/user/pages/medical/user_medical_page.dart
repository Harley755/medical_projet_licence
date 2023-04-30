import 'package:flutter/material.dart';

class UserMedicalPage extends StatefulWidget {
  const UserMedicalPage({super.key});

  @override
  State<UserMedicalPage> createState() => _UserMedicalPageState();
}

class _UserMedicalPageState extends State<UserMedicalPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("User Medical Page"),
      ),
    ));
  }
}
