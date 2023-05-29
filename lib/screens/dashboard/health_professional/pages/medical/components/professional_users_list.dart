import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class ProfessionalUserList extends StatefulWidget {
  const ProfessionalUserList({super.key});

  @override
  State<ProfessionalUserList> createState() => _ProfessionalUserListState();
}

class _ProfessionalUserListState extends State<ProfessionalUserList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'user')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Center(
              child: RobotoFont(
                title: "Erreur de chargement des données",
                size: getProportionateScreenWidth(13.0),
              ),
            );
          } else if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  leading: CircleAvatar(
                    radius: 26.0,
                    backgroundImage: NetworkImage(user['photoUrl'] == ""
                        ? "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg"
                        : user['photoUrl']),
                  ),
                  title: RobotoFont(
                    title:
                        "${user['prenom'].isNotEmpty ? user['prenom'][0] + (user['prenom'].length >= 2 ? ' ${user['prenom'][1]}' : '') : ''} ${user['nom']}",
                    color: kUserResColor,
                    size: getProportionateScreenWidth(17.0),
                    fontWeight: FontWeight.w700,
                  ),
                  subtitle: RobotoFont(
                    title: user['email'],
                    color: kSecondaryColor,
                    size: getProportionateScreenWidth(13.0),
                  ),
                );
              },
            );
          }
        }

        return const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      },
    );
  }
}
