import "package:flutter/material.dart";
import "package:medical_projet/screens/dashboard/health_professional/pages/profile/associated_account/components/professional_associated_body.dart";
import "package:medical_projet/screens/dashboard/user/pages/profile/associated_account/components/associated_account_body.dart";
import "package:medical_projet/size_config.dart";
import "package:medical_projet/utils/constants.dart";

class AssociatedAccount extends StatefulWidget {
  static String routeName = "/user/associated-account";
  const AssociatedAccount({super.key});

  @override
  State<AssociatedAccount> createState() => _AssociatedAccountState();
}

class _AssociatedAccountState extends State<AssociatedAccount> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes comptes",
          style: TextStyle(color: kSecondaryColor),
        ),
        centerTitle: true,
      ),
      body: const AssociatedAccountBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
