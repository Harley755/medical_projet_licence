import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/identity/components/body.dart';
import 'package:medical_projet/size_config.dart';

class ProfessionalProfileIdentity extends StatefulWidget {
  static String routeName = "/user/profile/identity";

  const ProfessionalProfileIdentity({super.key});

  @override
  State<ProfessionalProfileIdentity> createState() =>
      _ProfessionalProfileIdentityState();
}

class _ProfessionalProfileIdentityState
    extends State<ProfessionalProfileIdentity> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modifications",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: BodyProfessionalIdentityReadOnly(formKey: formKey),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 60,
                color: Colors.black.withOpacity(.4),
                offset: const Offset(0, 25),
              )
            ],
          ),
          child: DefaultButton(
            text: "Mettre à jour",
            press: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                // if all are valid then go to success screen
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
        ),
      ),
    );
  }
}
