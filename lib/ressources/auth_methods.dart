import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_projet/models/user_model.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // RECUPERER TOUTES LES INFORMATIONS DE L'UTILISATEUR CONNECTE
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // INSCRIPTION COMPTE INFORMATIF
  Future<String> signUpUser({
    required nom,
    required prenom,
    required email,
    required password,
  }) async {
    String response = "";

    try {
      // VERIFICATION DES CHAMPS
      if (nom.isNotEmpty ||
          prenom.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        // ON ENREGISTRE L'UTILISATEUR
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        model.User user = model.User(
          userId: credential.user!.uid,
          nom: nom,
          prenom: prenom,
          email: email,
          photoUrl: '',
          telephone: '',
          groupeSanguinId: '',
          nomContactUrgence: '',
          telephoneContactUrgence: '',
        );
        // ON AJOUTE L'UTILISATEUR A FIREBASE
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        response = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        response = "L'e-mail est mal formaté.";
      } else if (e.code == 'weak-password') {
        response = 'Votre mot de passe doit comporter au moins 8 caractères';
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
