import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/auth/sign_up/components/body_admin_sign_up.dart';
import 'package:medical_projet/size_config.dart';

class AdminSignUpScreen extends StatefulWidget {
  static String routeName = "/admin/sign_up";

  const AdminSignUpScreen({super.key});

  @override
  State<AdminSignUpScreen> createState() => _AdminSignUpScreenState();
}

class _AdminSignUpScreenState extends State<AdminSignUpScreen> {
  String hashPassword({required String passwordToHash}) {
    String salt = "110ec58a-a0f2-4ac4-8393-c866d813b8d1";
    List<int> bytes = utf8.encode(passwordToHash + salt);
    // calcule le hash SHA-256
    Digest hash = sha256.convert(bytes);
    // affiche le hash sous forme de chaîne de caractères hexadéc
    print(hash.toString());
    return hash.toString();
  }

  @override
  void initState() {
    print(hashPassword(passwordToHash: 'Fr7!zf4n9Q'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: const BodyAdminSignUp(),
    );
  }
}
