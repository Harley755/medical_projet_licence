import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

import 'package:medical_projet/models/compte_model.dart' as model;
import 'package:uuid/uuid.dart';

class CompteMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String hashPassword({required passwordToHash}) {
    List<int> bytes = utf8.encode(passwordToHash);
    // calcule le hash SHA-256
    Digest hash = sha256.convert(bytes);
    // affiche le hash sous forme de chaîne de caractères hexadéc
    print(hash.toString());
    return hash.toString();
  }

  Future<String> addCompte({
    required String compteId,
    required String nom,
    required String prenom,
    required String email,
    required String compteType,
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
          userId.isNotEmpty) {
        // ON ENREGISTRE L'UTILISATEUR
        // convertit la chaîne en une liste de bytes
        var compteID = const Uuid().v1();
        model.Compte compte = model.Compte(
          compteId: compteID,
          nom: nom,
          prenom: prenom,
          email: email,
          compteType: compteType,
          userId: userId,
        );
        // ON AJOUTE LE COMPTE A FIREBASE
        await _firestore
            .collection('comptes')
            .doc(compteID)
            .set(compte.toJson());
        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
