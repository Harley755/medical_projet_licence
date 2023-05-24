import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/sign_in/components/account_body.dart';
import 'package:medical_projet/size_config.dart';

class AccountInfoSignInScreen extends StatelessWidget {
  static String routeName = "/profile/info_sign_in";
  final String email;
  const AccountInfoSignInScreen({super.key, required this.email});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20.0),
        vertical: getProportionateScreenWidth(20.0),
      ),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -30,
              child: Container(
                width: 60.0,
                height: 7.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            AccountBodyInfoSignIn(email: email),
          ],
        ),
      ),
    );
  }
}
