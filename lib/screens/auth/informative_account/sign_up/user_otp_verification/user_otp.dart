import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/components/otp_form.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UserOtp extends StatefulWidget {

  const UserOtp({super.key});

  @override
  State<UserOtp> createState() => _UserOtpState();
}

class _UserOtpState extends State<UserOtp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  "Veuillez entrer votre numéro de téléphone",
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 64.0),

                // CIRCULAR WIDGET TO ACCEPT AND SHOW OUR SELECTED FILE
                const OtpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
