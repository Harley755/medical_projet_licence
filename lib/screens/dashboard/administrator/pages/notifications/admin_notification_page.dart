import 'package:flutter/material.dart';
import 'package:medical_projet/utils/constants.dart';

class AdminNotificationPage extends StatelessWidget {
  const AdminNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes notifications",
          style: TextStyle(
            color: kSecondaryColor,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
