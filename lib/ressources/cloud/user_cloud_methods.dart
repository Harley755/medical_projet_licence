import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_projet/models/user_model.dart' as model;

class UserCloudMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getAllDocumentsInCollection(
      String collectionPath) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionPath).get();
    return querySnapshot.docs;
  }

  // Future<String> modifyUserIdentity({
  //   required nom,
  //   required prenom,
  //   required sexe,
  //   required poids,
  //   required age,
  //   required relation,
  //   required groupeSanguinId,
  //   required nomContactUrgence,
  //   required telephoneContactUrgence,
  // }) {
  //   String response = "Quelque chose s'est mal passé";
  //   try {} catch (e) {}
  //   return response;
  // }

  Future<String> updateUserIdentity({
    required nom,
    required prenom,
    required sexe,
    required poids,
    required age,
    required groupeSanguinId,
    required nomContactUrgence,
    required telephoneContactUrgence,
    required relation,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      User? currentUser = _auth.currentUser;
      // VERIFICATION DES CHAMPS
      if (nom.isNotEmpty ||
          prenom.isNotEmpty ||
          sexe.isNotEmpty ||
          poids.isNotEmpty ||
          age.isNotEmpty ||
          groupeSanguinId.isNotEmpty ||
          nomContactUrgence.isNotEmpty ||
          telephoneContactUrgence.isNotEmpty ||
          relation.isNotEmpty) {
        // ON UPDATE INFOS IDENTITE
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'nom': nom,
          'prenom': prenom,
          'sexe': sexe,
          'poids': poids,
          'age': age,
          'groupeSanguinId': groupeSanguinId,
          'nomContactUrgence': nomContactUrgence,
          'telephoneContactUrgence': telephoneContactUrgence,
          'relation': relation,
        });
        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
