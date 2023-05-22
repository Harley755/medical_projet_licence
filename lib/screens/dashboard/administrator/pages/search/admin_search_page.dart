import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/search/components/body.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';

class AdminSearchPage extends StatefulWidget {
  static String routeName = "/professional/search";

  const AdminSearchPage({super.key});

  @override
  State<AdminSearchPage> createState() => _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearchPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Utilisateurs",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const BodyAdminSearch(),
    );
  }
}
