import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/sign_in/components/account_sign_in_form.dart';
import 'package:medical_projet/utils/constants.dart';

class AccountBodyInfoSignIn extends StatelessWidget {
  final String email;
  const AccountBodyInfoSignIn({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bienvenue\nsur votre compte",
            style: headingStyle,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 64.0),

          // CIRCULAR WIDGET TO ACCEPT AND SHOW OUR SELECTED FILE
          AccountSignInForm(email: email),
        ],
      ),
    );
  }
}
