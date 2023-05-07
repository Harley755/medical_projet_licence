import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/components/body.dart';
import 'package:medical_projet/size_config.dart';

class OtpVerification extends StatefulWidget {
  final TextEditingController phoneNumber;
  static String routeName = "/otp";

  const OtpVerification({super.key, required this.phoneNumber});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: OtpVerificationBody(phone: widget.phoneNumber),
    );
  }
}
