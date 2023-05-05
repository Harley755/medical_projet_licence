import 'package:flutter/material.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/admin_chat_page_body.dart';
import 'package:medical_projet/size_config.dart';

class AdminChatPage extends StatefulWidget {
  static String routeName = "/admin/chat/";
  const AdminChatPage({super.key});

  @override
  State<AdminChatPage> createState() => _AdminChatPageState();
}

class _AdminChatPageState extends State<AdminChatPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Chat Page",
            style: TextStyle(color: kSecondaryColor),
          ),
          centerTitle: true,
        ),
        body: const AdminChatPageBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
