import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/components/identity_detail_page/components/identity_detail_form.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_modfy_profile/user_profile_identity_modify.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/components/body.dart';
import 'package:medical_projet/size_config.dart';

class IdentityDetail extends StatefulWidget {
  static String routeName = "/user/profile/identity";
  final String userId;

  const IdentityDetail({
    super.key,
    required this.userId,
  });

  @override
  State<IdentityDetail> createState() => _IdentityDetailState();
}

class _IdentityDetailState extends State<IdentityDetail> {
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
              IdentityDetailFormReadOnly(userId: widget.userId),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
