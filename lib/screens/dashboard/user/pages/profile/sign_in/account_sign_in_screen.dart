import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_in/components/body.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/sign_in/components/account_body.dart';
import 'package:medical_projet/size_config.dart';

class AccountInfoSignInScreen extends StatelessWidget {
  static String routeName = "/info_sign_in";

  const AccountInfoSignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            size: getProportionateScreenWidth(30),
          ),
        ),
      ),
      body: const AccountBodyInfoSignIn(),
    );
  }
}
