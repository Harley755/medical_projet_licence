import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/components/user_medical_form.dart';
import 'package:medical_projet/size_config.dart';

class BodyUserMedical extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const BodyUserMedical({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
              UserMedicalForm(formKey: formKey),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
