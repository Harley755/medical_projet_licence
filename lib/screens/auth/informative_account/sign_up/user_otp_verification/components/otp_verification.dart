import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/components/body.dart';
import 'package:medical_projet/size_config.dart';

class OtpVerification extends StatelessWidget {
  static String routeName = "/otp";

  const OtpVerification({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: const OtpVerificationBody(),
    );
  }
}
