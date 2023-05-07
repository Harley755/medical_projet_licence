import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

import 'package:medical_projet/models/compte_model.dart' as model;

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
    required String userId,
    required String email,
    required String password,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (userId.isNotEmpty || email.isNotEmpty || password.isNotEmpty) {
        // ON ENREGISTRE L'UTILISATEUR
        // convertit la chaîne en une liste de bytes
        String passwordHashe = hashPassword(passwordToHash: password);
        model.Compte compte = model.Compte(
          compteId: userId,
          userId: userId,
          email: email,
          password: passwordHashe,
        );
        // ON AJOUTE L'UTILISATEUR A FIREBASE
        await _firestore.collection('comptes').doc(userId).set(compte.toJson());
        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
