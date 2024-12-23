import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';

import 'package:flutter/material.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/user_otp.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/waiting/professional_waiting.dart';
import 'package:medical_projet/screens/dashboard/users_dashboard.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UserSendEmailVerification extends StatefulWidget {
  const UserSendEmailVerification({
    Key? key,
  }) : super(key: key);

  @override
  State<UserSendEmailVerification> createState() =>
      _UserSendEmailVerificationState();
}

class _UserSendEmailVerificationState extends State<UserSendEmailVerification> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  User? user = FirebaseAuth.instance.currentUser;
  Timer? timer;

  late Future<model.User> _userDetailsFuture;
  model.User? _user;
  String _role = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    if (user != null) {
      isEmailVerified = user!.emailVerified;

      if (!isEmailVerified) {
        emailVerification();
        timer = Timer.periodic(
          const Duration(seconds: 3),
          (_) => checkEmailVerified(),
        );
      }

      _userDetailsFuture = UserAuthMethods().getUserIdentityDetails(
        userId: user!.uid,
      );
      _userDetailsFuture.then((userC) {
        setState(() {
          _user = userC;
          log(_user!.age.toString());
          log(_user!.role.toString());
          _role = _user!.role;
          _email = _user!.email;
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> emailVerification() async {
    if (!mounted) return; // Vérifie si le State est toujours actif
    UserAuthMethods().sendEmailVerification();
    setState(() => canResendEmail = false);
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return; // Vérifie si le State est toujours actif
    setState(() => canResendEmail = true);
  }

  Future<void> checkEmailVerified() async {
    if (!mounted) return; // Vérifie si le State est toujours actif
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer!.cancel();
  }

  getWidget() {
    if (isEmailVerified) {
      log("$isEmailVerified");
      log('hahha sous true: $_role');
      if (_role == 'user' || _role == 'admin') {
        log('hahha: $_role');
        return const UsersDashboardScreen();
      } else if (_role == 'professional') {
        log('hahha prooo: true');
        return ProfessionalWaiting(email: _email);
      }
    } else {
      log('hahha prooo last: true');
      return buildEmailVerificationPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: getWidget(),
    );
  }

  SingleChildScrollView buildEmailVerificationPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
        ),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * .2),
            RobotoFont(
              title:
                  "Nous vous avons envoyé un mail de vérification. Veuillez donc vérifier votre compte mail.",
              size: getProportionateScreenWidth(16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * .025),
            RobotoFont(
              title:
                  "Si vous n'avez pas encore reçu un mail de vérification, veuillez cliquer sur le bouton ci-dessous",
              size: getProportionateScreenWidth(16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * .1),
            DefaultButton(
              text: "Renvoyer l'email de vérification",
              press: canResendEmail
                  ? () => UserAuthMethods().sendEmailVerification()
                  : () {},
            ),
            SizedBox(
              height: getProportionateScreenHeight(17.0),
            ),
            TextButton(
              onPressed: () => UserAuthMethods().logOut(),
              child: RobotoFont(
                title: "Retour",
                color: kPrimaryColor,
                size: getProportionateScreenWidth(16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
