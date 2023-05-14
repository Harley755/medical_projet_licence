import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/details_conversation.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/recent_contact.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/search_chat.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/professional_search.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/professional_users_list.dart';
import 'package:medical_projet/size_config.dart';

class BodyProfessionalSearch extends StatefulWidget {
  const BodyProfessionalSearch({super.key});

  @override
  State<BodyProfessionalSearch> createState() => _BodyProfessionalSearchState();
}

class _BodyProfessionalSearchState extends State<BodyProfessionalSearch> {
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
          children: [
            const ProfessionalSearch(),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            RobotoFont(
              title: "Liste",
              size: 17.0,
              color: Colors.black.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            const ProfessionalUserList(),
          ],
        ),
      ),
    );
  }
}
