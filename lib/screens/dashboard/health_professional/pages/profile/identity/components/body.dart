import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/identity/components/professional_profile_form.dart';
import 'package:medical_projet/size_config.dart';

class BodyProfessionalIdentityReadOnly extends StatelessWidget {
  const BodyProfessionalIdentityReadOnly({super.key});

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
              const ProfessionalProfileFormReadOnly(),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
