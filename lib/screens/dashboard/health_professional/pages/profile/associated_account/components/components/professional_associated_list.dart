import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/ressources/cloud/compte_methods.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/detail_page.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class ProfessionalAssociatedList extends StatefulWidget {
  const ProfessionalAssociatedList({super.key});

  @override
  State<ProfessionalAssociatedList> createState() =>
      _ProfessionaAssociatedListState();
}

class _ProfessionaAssociatedListState
    extends State<ProfessionalAssociatedList> {
  @override
  void initState() {
    User currentUser = FirebaseAuth.instance.currentUser!;
    print(currentUser.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: CompteMethods().getUserAccounts(typeCompte: 'informatif'),
      builder: (BuildContext context,
          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
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
            List<DocumentSnapshot> accounts = snapshot.data!;
            return SizedBox(
              height: SizeConfig.screenHeight,
              child: Expanded(
                child: ListView.builder(
                  itemCount: accounts.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot accountSnapshot = accounts[index];
                    Map<String, dynamic> accountData =
                        accountSnapshot.data() as Map<String, dynamic>;
                    return InkWell(
                      // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => DetailPage(
                      //     userId: accountData['userId'],
                      //   ),
                      // )),
                      child: ListTile(
                        isThreeLine: true,
                        contentPadding: const EdgeInsets.all(0.0),
                        title: RobotoFont(
                          title:
                              '${accountData['prenom']} ${accountData['nom']}',
                          size: getProportionateScreenWidth(17.0),
                          fontWeight: FontWeight.w500,
                        ),
                        subtitle: RobotoFont(
                          title: accountData['email'],
                          size: getProportionateScreenWidth(13.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
