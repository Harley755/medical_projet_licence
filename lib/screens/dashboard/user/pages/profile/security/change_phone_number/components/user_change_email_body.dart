import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/security/change_email/components/user_change_email_form.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UserChangeEmailBody extends StatefulWidget {
  const UserChangeEmailBody({super.key});

  @override
  State<UserChangeEmailBody> createState() => _UserChangeEmailBodyState();
}

class _UserChangeEmailBodyState extends State<UserChangeEmailBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.1),

                Text(
                  "Veuillez entrer votre adresse email",
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 64.0),

                // CIRCULAR WIDGET TO ACCEPT AND SHOW OUR SELECTED FILE
                const UserChangeEmailForm(),

                SizedBox(height: SizeConfig.screenHeight * 0.1),

                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
