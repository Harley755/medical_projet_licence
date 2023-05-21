import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/components/body.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/body.dart';
import 'package:medical_projet/services/notification/notification_service.dart';
import 'package:medical_projet/size_config.dart';

class MedicalSignUpScreen extends StatefulWidget {
  static String routeName = "/medical_sign_up";
  const MedicalSignUpScreen({super.key});

  @override
  State<MedicalSignUpScreen> createState() => _MedicalSignUpScreenState();
}

class _MedicalSignUpScreenState extends State<MedicalSignUpScreen> {
  @override
  void initState() {
    currentUser();

    super.initState();
  }

  currentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: PoppinsFont(
          title: "Créer un compte",
          size: getProportionateScreenWidth(30.0),
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: const BodyMedicalSignUp(),
    );
  }
}
