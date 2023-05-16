import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/security/change_email/components/user_change_email_form.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/security/change_password/components/user_change_password_form.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UserChangePasswordBody extends StatefulWidget {
  const UserChangePasswordBody({super.key});

  @override
  State<UserChangePasswordBody> createState() => _UserChangePasswordBodyState();
}

class _UserChangePasswordBodyState extends State<UserChangePasswordBody> {
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
                const UserChangePasswordForm(),

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
