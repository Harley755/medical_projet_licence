import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:medical_projet/ressources/cloud/compte_methods.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/sign_up_screen.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/medical/medical_account.dart';

class InterScreens extends StatefulWidget {
  static String routeName = "/user/profile-inter-screen";
  const InterScreens({super.key});

  @override
  State<InterScreens> createState() => _InterScreensState();
}

class _InterScreensState extends State<InterScreens> {
  bool _hasMedicalAccount = false;

  numberOfMedicalAccount() async {
    Future<List<DocumentSnapshot>> list =
        CompteMethods().getUserAccounts(typeCompte: 'Medical');
    int listLenght = (await list).length;
    log(listLenght.toString());
    if (listLenght >= 1) {
      setState(() {
        _hasMedicalAccount = true;
      });
    } else {
      setState(() {
        _hasMedicalAccount = false;
      });
    }
  }

  @override
  void initState() {
    numberOfMedicalAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _hasMedicalAccount
        ? const MedicalAccount()
        : const MedicalSignUpScreen();
  }
}
