import 'dart:async';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/user_otp.dart';
import 'package:medical_projet/screens/dashboard/users_dashboard.dart';
import 'package:medical_projet/services/provider/user_provider.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:provider/provider.dart';

class UserSendEmailVerification extends StatefulWidget {
  const UserSendEmailVerification({super.key});

  @override
  State<UserSendEmailVerification> createState() =>
      _UserSendEmailVerificationState();
}

class _UserSendEmailVerificationState extends State<UserSendEmailVerification> {
  late bool isEmailVerified = false;
  late bool canResendEmail = false;
  final User? user = FirebaseAuth.instance.currentUser;
  Timer? timer;
  bool isDisposed = false;

  @override
  void initState() {
    if (user != null) {
      isEmailVerified = user!.emailVerified;

      if (!isEmailVerified) {
        emailVerification();
        timer = Timer.periodic(
          const Duration(seconds: 3),
          (_) => checkEmailVerified(),
        );
      }
    }
    super.initState();
  }

  Future emailVerification() async {
    if (isDisposed) return;
    UserMethods().sendEmailVerification();
    setState(() => canResendEmail = false);
    await Future.delayed(const Duration(seconds: 5));
    setState(() => canResendEmail = true);
  }

  Future checkEmailVerified() async {
    if (isDisposed) return;
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer!.cancel();
  }

  @override
  void dispose() {
    isDisposed = true;
    timer?.cancel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: isEmailVerified
          ? const UsersDashboardScreen()
          : SingleChildScrollView(
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
                          "Si vous n'avez pas encore reçu un mail de vérifivation, veuillez cliquer sur le bouton ci-dessous",
                      size: getProportionateScreenWidth(16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * .1),
                    DefaultButton(
                      text: "Renvoyer l'email de vérification",
                      press: canResendEmail
                          ? () => UserMethods().sendEmailVerification()
                          : () {},
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(17.0),
                    ),
                    TextButton(
                      onPressed: () => UserMethods().logOut(),
                      child: RobotoFont(
                        title: "Retour",
                        color: kPrimaryColor,
                        size: getProportionateScreenWidth(16),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
