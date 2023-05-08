import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_modfy_profile/components/user_profile_form_modify.dart';
import 'package:medical_projet/size_config.dart';

class BodyUserIdentity extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const BodyUserIdentity({super.key, required this.formKey});

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
              UserProfileFormModify(formKey: formKey),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
