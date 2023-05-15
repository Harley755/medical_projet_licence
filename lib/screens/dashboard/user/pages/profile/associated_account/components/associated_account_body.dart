import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/associated_account/components/account_list.dart';
import 'package:medical_projet/size_config.dart';

class AssociatedAccountBody extends StatefulWidget {
  const AssociatedAccountBody({super.key});

  @override
  State<AssociatedAccountBody> createState() => _AssociatedAccountBody();
}

class _AssociatedAccountBody extends State<AssociatedAccountBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            const AccountList(),
          ],
        ),
      ),
    );
  }
}
