import 'package:flutter/material.dart';
import 'package:medical_projet/ressources/auth/user_methods.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/components/otp_code_form.dart';
import 'package:medical_projet/screens/dashboard/users_dashboard.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/utils/functions.dart';

class OtpVerificationBody extends StatefulWidget {
  final TextEditingController phone;
  const OtpVerificationBody({super.key, required this.phone});

  @override
  State<OtpVerificationBody> createState() => _OtpVerificationBodyState();
}

class _OtpVerificationBodyState extends State<OtpVerificationBody> {
  @override
  Widget build(BuildContext context) {
    String phoneNumber = widget.phone.text.trim();
    String hiddenPhoneNumber = phoneNumber
            .substring(0, phoneNumber.length - 4)
            .replaceAll(RegExp(r'\d'), '*') +
        phoneNumber.substring(phoneNumber.length - 4);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to $hiddenPhoneNumber"),
              buildTimer(),
              const OtpCodeForm(),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: const Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
