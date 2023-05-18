import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_projet/models/admin_model.dart' as model;
import 'package:medical_projet/ressources/cloud/compte_methods.dart';
import 'package:uuid/uuid.dart';

class AdminCloudMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String hashPassword({required passwordToHash}) {
    String salt = "110ec58a-a0f2-4ac4-8393-c866d813b8d1";
    List<int> bytes = utf8.encode(passwordToHash + salt);
    // calcule le hash SHA-256
    Digest hash = sha256.convert(bytes);
    // affiche le hash sous forme de chaîne de caractères hexadéc
    print(hash.toString());
    return hash.toString();
  }

  // ADMIN
  // INSCRIPTION COMPTE INFORMATIF
  Future<String> signUpAdmin({
    required nom,
    required prenom,
    required email,
    required secretCode,
    required password,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (nom.isNotEmpty ||
          prenom.isNotEmpty ||
          email.isNotEmpty ||
          secretCode.isNotEmpty ||
          password.isNotEmpty) {
        // ON ENREGISTRE L'UTILISATEUR
        String hashSecretCode = hashPassword(passwordToHash: secretCode);
        if (hashSecretCode ==
            "587f2ef4ebd8d216e80d6f0e091dd794c5a6ce58d6b80b7a71bfb12f69ce3a8d") {
          UserCredential credential =
              await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          model.Admin user = model.Admin(
            userId: credential.user!.uid,
            nom: nom,
            prenom: prenom,
            email: email,
            secretCode: secretCode,
            telephone: '',
            role: 'admin',
          );
          // ON AJOUTE L'UTILISATEUR A FIREBASE
          print("user Ajouté");
          await _firestore
              .collection('users')
              .doc(credential.user!.uid)
              .set(user.toJson());

          // ON AJOUTE LE COMPTE
          await CompteMethods().addCompte(
            compteId: const Uuid().v1(),
            nom: nom,
            prenom: prenom,
            email: email,
            compteType: 'admin',
            photoUrl: '',
            userId: credential.user!.uid,
          );
          print("Compte Ajouté");

          // CREER SA TABLE ANTECEDENT
          await _firestore
              .collection('antecedents')
              .doc(credential.user!.uid)
              .set({
            'antecedentId': credential.user!.uid,
            'antecedentMedicaux': "",
            'maladiesChronique': "",
            'antecedentTraumatique': "",
            'antecedentAllergique': "",
            'antecedentChirurgie': "",
            'antecedentMaladieInfecteuse': "",
            'userId': credential.user!.uid,
          });
          print("Compte Ajouté");

          response = "success";
        } else {
          response = "invalid-code";
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        response = "L'e-mail est mal valide.";
      } else if (e.code == 'email-already-in-use') {
        response = "Votre adresse email a déja été utilisé.";
      } else if (e.code == 'operation-not-allowed') {
        response = "Votre compte n'a pas été activé.";
      } else if (e.code == 'weak-password') {
        response = 'Votre mot de passe doit comporter au moins 8 caractères.';
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
