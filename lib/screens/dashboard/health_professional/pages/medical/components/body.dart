import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/details_conversation.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/recent_contact.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/search_chat.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/detail_page.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/professional_list_result.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/professional_search.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/professional_users_list.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class BodyProfessionalSearch extends StatefulWidget {
  const BodyProfessionalSearch({super.key});

  @override
  State<BodyProfessionalSearch> createState() => _BodyProfessionalSearchState();
}

class _BodyProfessionalSearchState extends State<BodyProfessionalSearch> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool _isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(17),
              vertical: getProportionateScreenWidth(17),
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Le reste du contenu ici...
                  TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(15),
                        horizontal: getProportionateScreenHeight(30),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: kPrimaryColor,
                      ),
                      labelText: 'Rechercher',
                      hintText: "Rechercher un utilisateur",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    onChanged: (String _) {
                      setState(() {
                        if (_ == "") {
                          _isShowUsers = false;
                        } else {
                          _isShowUsers = true;
                        }
                      });
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(15.0)),
                  RobotoFont(
                    title: "Liste",
                    size: 17.0,
                    color: Colors.black.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: getProportionateScreenHeight(15.0)),
                  !_isShowUsers
                      ? const ProfessionalUserList()
                      : ProfessionalListResult(
                          searchController: searchController,
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
