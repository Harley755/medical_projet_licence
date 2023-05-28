import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medical_projet/models/admin_model.dart' as model;
import 'package:medical_projet/ressources/cloud/compte_methods.dart';
import 'package:medical_projet/services/notification/notification_service.dart';
import 'package:uuid/uuid.dart';

class AdminCloudMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String hashPassword({required String passwordToHash}) {
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
    required token,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (token.isNotEmpty ||
          nom.isNotEmpty ||
          prenom.isNotEmpty ||
          email.isNotEmpty ||
          secretCode.isNotEmpty ||
          password.isNotEmpty) {
        // ON ENREGISTRE L'UTILISATEUR
        String hashSecretCode = hashPassword(passwordToHash: secretCode);
        if (hashSecretCode ==
            "6df809c2b81414e46c2fca398c89497ffd29533877aa280433846dec476d8250") {
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
            secretCode: hashSecretCode,
            telephone: '',
            role: 'admin',
          );
          // ON AJOUTE L'UTILISATEUR A FIREBASE
          log("Admin Ajouté");
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
          log("Compte Ajouté");

          // // ADD DEVICE TOKEN
          // NotificationServices().saveTokenAndId(
          //   collection: 'adminToken',
          //   doc: credential.user!.uid,
          //   token: token,
          //   userId: credential.user!.uid,
          // );
          log("TOKEN ENVOYEE");

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

  Future<String> updateStatut({
    required String nom,
    required String prenom,
    required String email,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (nom.isNotEmpty || prenom.isNotEmpty || email.isNotEmpty) {
        // ON AJOUTE LE COMPTE A FIREBASE
        await _firestore.collection('comptes').doc(email).update({
          'nom': nom,
          'prenom': prenom,
          'updatedAt': DateTime.now(),
        });
        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
