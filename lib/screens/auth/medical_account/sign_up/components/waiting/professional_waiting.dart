import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/models/statut_model.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/ressources/cloud/statut_methods.dart';
import 'package:medical_projet/screens/auth/auth_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/waiting/components/no_data_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/waiting/components/refuse_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/waiting/components/waiting_screen.dart';
import 'package:medical_projet/screens/dashboard/users_dashboard.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class ProfessionalWaiting extends StatefulWidget {
  final String email;

  const ProfessionalWaiting({Key? key, required this.email}) : super(key: key);

  @override
  State<ProfessionalWaiting> createState() => _ProfessionalWaitingState();
}

class _ProfessionalWaitingState extends State<ProfessionalWaiting> {
  // Stream<dynamic> _statutStream = const Stream.empty();
  User? user = FirebaseAuth.instance.currentUser;
  late Future<Statut> _statutDetailsFuture;
  Statut? _statutC;
  String _statut = "";

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _statutDetailsFuture =
          StatutMethods().getStatutDetails(email: widget.email);
      _statutDetailsFuture.then((userC) {
        setState(() {
          _statutC = userC;
          log(_statutC!.etatStatut.toString());
          _statut = _statutC!.etatStatut;
        });
      });
    }
  }

  Widget getStatutWidget() {
    if (_statut == 'attente') {
      return const BuildWaitingScreen();
    } else if (_statut == 'accepter') {
      return const UsersDashboardScreen();
    } else if (_statut == 'refuser') {
      return const BuildRefuseScreen();
    }
    return const NoDataScreen();
  }

  @override
  Widget build(BuildContext context) {
    return getStatutWidget();
  }
}
