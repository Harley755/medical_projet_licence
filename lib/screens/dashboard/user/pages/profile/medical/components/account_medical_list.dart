import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/ressources/cloud/compte_methods.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/detail_page.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/sign_in/account_sign_in_screen.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class AccountMedicalList extends StatefulWidget {
  const AccountMedicalList({super.key});

  @override
  State<AccountMedicalList> createState() => _AccountMedicalListState();
}

class _AccountMedicalListState extends State<AccountMedicalList> {
  @override
  void initState() {
    User currentUser = FirebaseAuth.instance.currentUser!;
    print(currentUser.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: CompteMethods().getUserAccounts(typeCompte: 'Medical'),
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
          return Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: accounts.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot accountSnapshot = accounts[index];
                      Map<String, dynamic> accountData =
                          accountSnapshot.data() as Map<String, dynamic>;

                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AccountInfoSignInScreen(
                              email: accountData['email'],
                            ),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(10.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0.0),
                            leading: CircleAvatar(
                              radius: 26.0,
                              backgroundImage: NetworkImage(
                                accountData['photoUrl'] == ""
                                    ? "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg"
                                    : accountData['photoUrl'],
                              ),
                            ),
                            title: RobotoFont(
                              title:
                                  '${accountData['prenom']} ${accountData['nom']}',
                              size: getProportionateScreenWidth(17.0),
                              fontWeight: FontWeight.w500,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: getProportionateScreenHeight(5.0)),
                                RobotoFont(
                                  title: accountData['email'],
                                  size: getProportionateScreenWidth(13.0),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(5.0)),
                                RobotoFont(
                                  title: 'compte ${accountData['compteType']}',
                                  size: getProportionateScreenWidth(13.0),
                                  fontWeight: FontWeight.w300,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(80.0),
              )
            ],
          );
        }
      },
    );
  }
}
