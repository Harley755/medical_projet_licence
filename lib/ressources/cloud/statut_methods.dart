import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

import 'package:medical_projet/models/compte_model.dart' as model;
import 'package:medical_projet/models/statut_model.dart' as model;

class StatutMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addStatut({
    required String doc,
    required String statutId,
    required String etatStatut,
    required String motif,
    required String userId,
    required String compteId,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (doc.isNotEmpty ||
          motif.isNotEmpty ||
          userId.isNotEmpty ||
          compteId.isNotEmpty ||
          statutId.isNotEmpty) {
        // ON ENREGISTRE L'UTILISATEUR
        // convertit la chaîne en une liste de bytes
        // var statutId = const Uuid().v1();
        model.Statut statut = model.Statut(
          statutId: statutId,
          compteId: compteId,
          etatStatut: 'attente',
          motif: motif,
          userId: userId,
          createdAt: DateTime.now(),
        );
        // ON AJOUTE LE COMPTE A FIREBASE
        await _firestore.collection('statuts').doc(doc).set(statut.toJson());
        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updateStatut({
    required String doc,
    required String statutId,
    required String userId,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (statutId.isNotEmpty || userId.isNotEmpty) {
        // ON AJOUTE LE COMPTE A FIREBASE
        await _firestore.collection('statuts').doc(doc).update({
          'statutId': statutId,
          'userId': userId,
        });
        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> updateEtatAndStatut({
    required String docEmail,
    required String etatStatut,
    required String motif,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (etatStatut.isNotEmpty || motif.isNotEmpty) {
        // ON AJOUTE LE COMPTE A FIREBASE
        await _firestore.collection('statuts').doc(docEmail).update({
          'etatStatut': etatStatut,
          'motif': motif,
        });
        response = "success";
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  // Stream<dynamic> getAccountState({required String email}) async* {
  //   if (email != "") {
  //     DocumentSnapshot bloodTypeSnapshot =
  //         await _firestore.collection('statuts').doc(email).get();

  //     dynamic attributeValue = bloodTypeSnapshot.get('etatStatut');

  //     yield attributeValue;
  //   } else {
  //     yield "";
  //   }
  // }
  Future<model.Statut> getStatutDetails({required String? email}) async {
    if (email != "") {
      DocumentSnapshot snap =
          await _firestore.collection('statuts').doc(email).get();
      return model.Statut.fromSnap(snap);
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found with this credentials.',
      );
    }
  }
}
