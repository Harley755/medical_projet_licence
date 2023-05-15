import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/associated_account/components/components/professional_associated_list.dart';
import 'package:medical_projet/size_config.dart';

class ProfessionalAssociatedBody extends StatefulWidget {
  const ProfessionalAssociatedBody({super.key});

  @override
  State<ProfessionalAssociatedBody> createState() =>
      _ProfessionalAssociatedBody();
}

class _ProfessionalAssociatedBody extends State<ProfessionalAssociatedBody> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(17),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ProfessionalAssociatedList(),
          ],
        ),
      ),
    );
  }
}
