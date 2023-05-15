import "package:flutter/material.dart";
import "package:medical_projet/screens/dashboard/health_professional/pages/profile/associated_account/components/professional_associated_body.dart";
import "package:medical_projet/size_config.dart";
import "package:medical_projet/utils/constants.dart";

class ProfessionalAssociatedAccount extends StatefulWidget {
  static String routeName = "/professional/associated-account";
  const ProfessionalAssociatedAccount({super.key});

  @override
  State<ProfessionalAssociatedAccount> createState() =>
      _ProfessionalAssociatedAccountState();
}

class _ProfessionalAssociatedAccountState
    extends State<ProfessionalAssociatedAccount> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes comptes utilisateur",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const ProfessionalAssociatedBody(),
    );
  }
}
