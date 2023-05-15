import "package:flutter/material.dart";

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mon compte utilisateur",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
    );
  }
}
