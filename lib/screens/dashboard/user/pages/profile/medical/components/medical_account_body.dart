import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/medical/components/account_medical_list.dart';
import 'package:medical_projet/size_config.dart';

class MedicalAccountBody extends StatefulWidget {
  const MedicalAccountBody({super.key});

  @override
  State<MedicalAccountBody> createState() => _MedicalAccountBody();
}

class _MedicalAccountBody extends State<MedicalAccountBody> {
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
            const AccountMedicalList(),
          ],
        ),
      ),
    );
  }
}
