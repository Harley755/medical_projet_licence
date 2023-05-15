import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/ressources/cloud/compte_methods.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/detail_page.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class AccountList extends StatefulWidget {
  const AccountList({super.key});

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  void initState() {
    User currentUser = FirebaseAuth.instance.currentUser!;
    print(currentUser.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: CompteMethods().getUserInformatifAccounts(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<DocumentSnapshot>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          ); // Afficher une indication de chargement si la liste est en cours de récupération
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Une erreur est survenue : ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Aucun compte trouvée.'));
        } else {
          List<DocumentSnapshot> accounts = snapshot.data!;
          print(accounts);
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
                      contentPadding: const EdgeInsets.all(0.0),
                      leading: CircleAvatar(
                        radius: 26.0,
                        backgroundImage: NetworkImage(
                          '${accountData['phototUrl']}',
                        ),
                      ),
                      title: RobotoFont(
                        title: '${accountData['prenom']} ${accountData['nom']}',
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
      },
    );
  }
}
