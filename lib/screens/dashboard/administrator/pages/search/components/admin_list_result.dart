import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/detail_page.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class AdminListResult extends StatefulWidget {
  final TextEditingController searchNomController;
  final TextEditingController searchPrenomController;
  const AdminListResult({
    super.key,
    required this.searchNomController,
    required this.searchPrenomController,
  });

  @override
  State<AdminListResult> createState() => _AdminListResultState();
}

class _AdminListResultState extends State<AdminListResult> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .where('nom', isEqualTo: widget.searchNomController.text)
          .where('prenom', arrayContains: widget.searchPrenomController.text)
          .orderBy('prenom') // Tri par ordre alphabétique du prénom
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        }
        if (!snapshot.hasData || (snapshot.data! as dynamic).docs.length == 0) {
          return Center(
            child: RobotoFont(
              title: "Pas d'utilisateur trouvé",
              size: getProportionateScreenWidth(16.0),
            ),
          );
        }
        return SizedBox(
          height: SizeConfig.screenHeight,
          child: Expanded(
            child: ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  leading: CircleAvatar(
                    radius: 26.0,
                    backgroundImage: NetworkImage(
                      (snapshot.data! as dynamic).docs[index]['photoUrl'] == ""
                          ? "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg"
                          : (snapshot.data! as dynamic).docs[index]['photoUrl'],
                    ),
                  ),
                  title: RobotoFont(
                    title: (snapshot.data! as dynamic).docs[index]['prenom'][0],
                    size: getProportionateScreenWidth(17.0),
                    fontWeight: FontWeight.w500,
                  ),
                  subtitle: RobotoFont(
                    title: (snapshot.data! as dynamic).docs[index]['email'],
                    size: getProportionateScreenWidth(13.0),
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
