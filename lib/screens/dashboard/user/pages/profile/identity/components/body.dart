import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/components/user_profile_form.dart';
import 'package:medical_projet/size_config.dart';

class BodyUserIdentityReadOnly extends StatelessWidget {
  const BodyUserIdentityReadOnly({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
              const UserProfileFormReadOnly(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
