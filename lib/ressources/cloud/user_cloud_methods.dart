import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/cloud/antecedent_methods.dart';
import 'package:medical_projet/ressources/cloud/pieces_storage.dart';

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

  Future<String> updateProfessionalIdentity({
    required nom,
    required prenom,
    required pieceIdentiteName,
    required pieceIdentitePath,
    required specialite,
    required carteMedicaleName,
    required carteMedicalePath,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      User? currentUser = _auth.currentUser;
      // VERIFICATION DES CHAMPS
      if (nom.isNotEmpty ||
          prenom.isNotEmpty ||
          pieceIdentiteName.isNotEmpty ||
          pieceIdentitePath.isNotEmpty ||
          carteMedicaleName.isNotEmpty ||
          carteMedicalePath.isNotEmpty ||
          specialite.isNotEmpty) {
        // ON UPDATE INFOS IDENTITE
        String pieceI = await PiecesStorage().uploadPieces(
          uid: currentUser!.uid,
          pieceName: pieceIdentiteName,
          piecePath: pieceIdentitePath,
        );

        String carteM = await PiecesStorage().uploadPieces(
          uid: currentUser.uid,
          pieceName: carteMedicaleName,
          piecePath: carteMedicalePath,
        );
        await _firestore.collection('users').doc(currentUser.uid).update({
          'nom': nom,
          'prenom': prenom,
          'pieceIdentitePath': pieceI,
          'carteMedicalePath': carteM,
          'specialite': specialite,
        });

        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
