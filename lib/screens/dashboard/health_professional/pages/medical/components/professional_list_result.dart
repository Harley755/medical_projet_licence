import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/detail_page.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class ProfessionalListResult extends StatefulWidget {
  final TextEditingController searchController;
  const ProfessionalListResult({super.key, required this.searchController});

  @override
  State<ProfessionalListResult> createState() => _ProfessionalListResultState();
}

class _ProfessionalListResultState extends State<ProfessionalListResult> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .where(
            'nom',
            isGreaterThanOrEqualTo: widget.searchController.text,
          )
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        }
        if (!snapshot.hasData) {
          return const Text("Pas d'utilisateurs avec ce nom de famille");
        }
        return SizedBox(
          height: SizeConfig.screenHeight,
          child: Expanded(
            child: ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPage(
                      userId: (snapshot.data! as dynamic).docs[index]['userId'],
                    ),
                  )),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['photoUrl'],
                      ),
                    ),
                    title: RobotoFont(
                      title: (snapshot.data! as dynamic).docs[index]['prenom'],
                      size: getProportionateScreenWidth(17.0),
                      fontWeight: FontWeight.w500,
                    ),
                    subtitle: RobotoFont(
                      title: (snapshot.data! as dynamic).docs[index]['email'],
                      size: getProportionateScreenWidth(13.0),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
