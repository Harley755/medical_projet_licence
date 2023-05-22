import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

import 'package:medical_projet/models/compte_model.dart' as model;
import 'package:uuid/uuid.dart';

class CompteMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addCompte({
    required String compteId,
    required String nom,
    required String prenom,
    required String email,
    required String compteType,
    required String photoUrl,
    required String userId,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (userId.isNotEmpty ||
          nom.isNotEmpty ||
          prenom.isNotEmpty ||
          email.isNotEmpty ||
          compteType.isNotEmpty ||
          userId.isNotEmpty ||
          photoUrl.isNotEmpty) {
        // ON ENREGISTRE L'UTILISATEUR
        // convertit la chaîne en une liste de bytes
        var compteID = const Uuid().v1();
        model.Compte compte = model.Compte(
          compteId: compteID,
          nom: nom,
          prenom: prenom,
          email: email,
          compteType: compteType,
          photoUrl: photoUrl,
          userId: userId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        // ON AJOUTE LE COMPTE A FIREBASE
        await _firestore.collection('comptes').doc(email).set(compte.toJson());
        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updateCompte({
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

  Future<List<DocumentSnapshot>> getUserAccounts(
      {required String typeCompte}) async {
    // Récupérer l'utilisateur couramment connecté
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Effectuer la requête pour récupérer les comptes informatifs de l'utilisateur
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('comptes')
          .where('userId', isEqualTo: currentUser.uid)
          .where('compteType', isEqualTo: typeCompte)
          .get();

      // Retourner les résultats sous forme de liste de DocumentSnapshot
      return querySnapshot.docs;
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user currently logged in.',
      );
    }
  }
}
