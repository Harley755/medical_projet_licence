import 'package:flutter/material.dart';
import 'package:medical_projet/constants.dart';

class AdminChatPage extends StatefulWidget {
  const AdminChatPage({super.key});

  @override
  State<AdminChatPage> createState() => _AdminChatPageState();
}

class _AdminChatPageState extends State<AdminChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Admin Chat Page",
            style: TextStyle(color: kSecondaryColor),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
