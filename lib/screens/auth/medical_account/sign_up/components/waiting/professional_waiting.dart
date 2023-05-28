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
      return const BuildRefusScreen();
    }
    return const Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return getStatutWidget();
  }
}

class BuildRefusScreen extends StatelessWidget {
  const BuildRefusScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Votre compte a été refusé."),
          // Ajoutez d'autres éléments UI ou des actions si nécessaire
        ],
      ),
    );
  }
}

class BuildWaitingScreen extends StatelessWidget {
  const BuildWaitingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * .30,
                ),
                const CircularProgressIndicator(color: kPrimaryColor),
                const SizedBox(height: 16.0),
                const RobotoFont(
                  title:
                      "Veuillez patienter\nVotre demande est en cours de traitement...",
                  size: 20.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25.0),
                DefaultButton(
                  text: "Deconnexion",
                  press: () async {
                    await UserAuthMethods().logOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
