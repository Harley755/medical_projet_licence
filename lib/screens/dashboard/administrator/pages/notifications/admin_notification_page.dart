import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/notifications/components/body.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class AdminNotificationPage extends StatelessWidget {
  const AdminNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes notifications",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: const BodyAdminNotificationPage(),
    );
  }
}
