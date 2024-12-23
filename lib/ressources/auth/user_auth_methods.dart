import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/models/admin_model.dart' as model;
import 'package:medical_projet/models/professional_model.dart' as model;
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/models/antecedent_model.dart' as model;
import 'package:medical_projet/ressources/cloud/compte_methods.dart';
import 'package:medical_projet/ressources/cloud/pieces_storage.dart';
import 'package:medical_projet/ressources/cloud/statut_methods.dart';
import 'package:medical_projet/services/notification/notification_service.dart';
import 'package:uuid/uuid.dart';

class UserAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // RECUPERER TOUTES LES INFORMATIONS DE L'UTILISATEUR CONNECTE
  // Future<model.User> getUserIdentityDetails(String userId) async {
  //   User? currentUser = _auth.currentUser;

  //   if (currentUser != null) {
  //     DocumentSnapshot snap =
  //         await _firestore.collection('users').doc(currentUser.uid).get();
  //     return model.User.fromSnap(snap);
  //   } else {
  //     throw FirebaseAuthException(
  //       code: 'user-not-found',
  //       message: 'No user found with this credentials.',
  //     );
  //   }
  // }
  Future<model.User> getUserIdentityDetails({required String userId}) async {
    if (userId != "") {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(userId).get();
      return model.User.fromSnap(snap);
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found with this credentials.',
      );
    }
  }

  // Future<dynamic> getInfo({required String bloodTypeId}) async {
  //   if (bloodTypeId.isNotEmpty) {
  //     DocumentSnapshot bloodTypeSnapshot =
  //         await _firestore.collection('blood_type').doc(bloodTypeId).get();

  //     if (bloodTypeSnapshot.exists) {
  //       dynamic attributeValue = bloodTypeSnapshot.get('libelle');

  //       if (attributeValue != null) {
  //         return attributeValue;
  //       } else {
  //         throw Exception("Attribute not found in blood type document");
  //       }
  //     } else {
  //       throw Exception("Blood type document not found");
  //     }
  //   } else {
  //     throw Exception("Empty bloodTypeId");
  //   }
  // }

  Future<dynamic> getInfo({required String bloodTypeId}) async {
    if (bloodTypeId != "") {
      DocumentSnapshot bloodTypeSnapshot =
          await _firestore.collection('blood_type').doc(bloodTypeId).get();

      dynamic attributeValue = bloodTypeSnapshot.get('libelle');

      return attributeValue;
    } else {
      return "";
    }
  }

  // Future<dynamic> getInfo({
  //   required String collection,
  //   required String doc,
  //   required String attribut,
  // }) async {
  //   if (doc != "") {
  //     DocumentSnapshot bloodTypeSnapshot =
  //         await _firestore.collection(collection).doc(doc).get();

  //     dynamic attributeValue = bloodTypeSnapshot.get(attribut);

  //     return attributeValue;
  //   } else {
  //     return "";
  //   }
  // }

  Future<model.Professional> getProfessionalIdentityDetails(
      {required String userId}) async {
    if (userId != "") {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(userId).get();
      return model.Professional.fromSnap(snap);
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found with this credentials.',
      );
    }
  }

  Future<model.Admin> getAdminIdentityDetails({required String userId}) async {
    if (userId != "") {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(userId).get();
      return model.Admin.fromSnap(snap);
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found with this credentials.',
      );
    }
  }

  Future<model.Antecedent> getUserMedicalDetails(
      {required String userId}) async {
    if (userId != "") {
      DocumentSnapshot snap =
          await _firestore.collection('antecedents').doc(userId).get();
      return model.Antecedent.fromSnap(snap);
    } else {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found with this credentials.',
      );
    }
  }

  // INSCRIPTION COMPTE INFORMATIF
  Future<String> signUpUser({
    required nom,
    required prenom,
    required email,
    required password,
  }) async {
    String response = "Une erreur s'est produite";

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
        String prenomInput = prenom;
        List<String> prenomList = prenomInput.split(' ');
        model.User user = model.User(
          userId: credential.user!.uid,
          nom: nom,
          prenom: prenomList,
          email: email,
          poids: '',
          sexe: '',
          age: '',
          dateNaissance: '',
          photoUrl: '',
          telephone: '',
          groupeSanguinId: '',
          nomContactUrgence: '',
          telephoneContactUrgence: '',
          relation: '',
          role: 'user',
        );
        // ON AJOUTE L'UTILISATEUR A FIREBASE
        log("user Ajouté");
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());

        // ON AJOUTE LE COMPTE
        await CompteMethods().addCompte(
          compteId: const Uuid().v1(),
          nom: nom,
          prenom: prenomList,
          email: email,
          compteType: 'informatif',
          photoUrl: '',
          userId: credential.user!.uid,
        );
        log("CREATE USER INFO COMPTE AJOUTE");

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
        log("Compte Ajouté");

        response = "success";

        // ENVOIE UN MAIL DE VERIFICATION D'EMAIL
        // await sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        response = "L'e-mail n'est pas valide.";
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

  // INSCRIPTION COMPTE INFORMATIF POUR ENFANT9
  Future<String> signUpUserAssociatedAccount({
    required nom,
    required prenom,
    required email,
    required password,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (nom.isNotEmpty ||
          prenom.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        // AJOUTE LE COMPTE
        String prenomInput = prenom;
        List<String> prenomList = prenomInput.split(' ');
        log(_auth.currentUser!.uid);
        var compteID = const Uuid().v1();
        await CompteMethods().addCompte(
          compteId: compteID,
          nom: nom,
          prenom: prenomList,
          email: email,
          compteType: 'informatif',
          userId: _auth.currentUser!.uid,
          photoUrl: '',
        );
        log("Compte Ajouté");
        // ON ENREGISTRE L'UTILISATEUR
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        model.User user = model.User(
          userId: credential.user!.uid,
          nom: nom,
          prenom: prenomList,
          email: email,
          poids: '',
          sexe: '',
          age: '',
          dateNaissance: '',
          photoUrl: '',
          telephone: '',
          groupeSanguinId: '',
          nomContactUrgence: '',
          telephoneContactUrgence: '',
          relation: '',
          role: 'user',
        );
        // ON AJOUTE L'UTILISATEUR A FIREBASE
        log("user Ajouté");
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());

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
        log("Compte Ajouté");

        response = "success";

        // ENVOIE UN MAIL DE VERIFICATION D'EMAIL
        // await sendEmailVerification();
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

  Future<String> addPhoneNumber({
    required String phoneNumber,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (phoneNumber.isNotEmpty) {
        User? currentUser = _auth.currentUser;
        // ON ENREGISTRE LE NUMERO DE TELEPHONE
        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .update({'telephone': phoneNumber});
        response = "success";
        log("phone Number Update successfully");
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<String> sendOtpCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (phoneNumber.isNotEmpty) {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              response = "Le numéro de téléphone fournit n'est pas valide";
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            // Navigator.pushNamed(context, OtpVerification.routeName);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
        response = phoneNumber;
      }
    } catch (e) {
      response = e.toString();
    }
    return response;
  }

  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      log("user est null pour lui envoyer un mail de verification");
    }
  }

  Future<void> logOut() async {
    final user = FirebaseAuth.instance;
    if (user != null) {
      await user.signOut();
    } else {
      log("user est null pour lui envoyer un mail de verification");
    }
  }

  // CONNEXION USER COMPTE INFORMATIF
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String response = "Une erreur s'est produite";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        response = 'success';
      } else {
        response = 'Champs vide';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        response = "Votre adresse email n'est pas valide";
      } else if (e.code == 'user-disabled') {
        response = "Votre adresse email a été désactivé";
      } else if (e.code == 'user-not-found') {
        response = "Pas d'utilisateur correspondant à l'email donné";
      } else if (e.code == 'wrong-password') {
        response =
            "Votre Mot de passe n'est pas valide pour l'adresse e-mail donnée";
      }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// PROFESSIONAL
  // INSCRIPTION COMPTE INFORMATIF
  Future<String> signUpProfessional({
    required nom,
    required prenom,
    required email,
    required pieceIdentiteName,
    required pieceIdentitePath,
    required password,
    required specialite,
    required carteMedicaleName,
    required carteMedicalePath,
    required professionaltoken,
  }) async {
    String response = "Une erreur s'est produite";

    try {
      // VERIFICATION DES CHAMPS
      if (nom.isNotEmpty ||
          prenom.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          pieceIdentiteName.isNotEmpty ||
          pieceIdentitePath.isNotEmpty ||
          carteMedicaleName.isNotEmpty ||
          carteMedicalePath.isNotEmpty ||
          password.isNotEmpty ||
          specialite.isNotEmpty ||
          professionaltoken.isNotEmpty) {
        // ON AJOUTE LE COMPTE MEDICAL
        String prenomInput = prenom;
        List<String> prenomList = prenomInput.split(' ');
        log(_auth.currentUser!.uid);
        var compteID = const Uuid().v1();
        await CompteMethods().addCompte(
          compteId: compteID,
          nom: nom,
          prenom: prenomList,
          email: email,
          compteType: 'Medical',
          userId: _auth.currentUser!.uid,
          photoUrl: '',
        );

        await StatutMethods().addStatut(
          doc: email,
          statutId: _auth.currentUser!.uid,
          motif: '',
          userId: '',
          compteId: _auth.currentUser!.uid,
          etatStatut: 'attente',
        );

        // ON ENREGISTRE L'UTILISATEUR
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await StatutMethods().updateStatut(
          statutId: credential.user!.uid,
          userId: credential.user!.uid,
          doc: email,
        );

        log("Statut créé");

        String pieceI = await PiecesStorage().uploadPieces(
          uid: credential.user!.uid,
          pieceName: pieceIdentiteName,
          piecePath: pieceIdentitePath,
        );

        String carteM = await PiecesStorage().uploadPieces(
          uid: credential.user!.uid,
          pieceName: carteMedicaleName,
          piecePath: carteMedicalePath,
        );

        model.Professional user = model.Professional(
          userId: credential.user!.uid,
          nom: nom,
          prenom: prenomList,
          email: email,
          specialite: specialite,
          photoUrl: '',
          photoCarteMedicale: carteM,
          photoPieceIdentite: pieceI,
          telephone: '',
          role: 'professional',
        );
        // ON AJOUTE L'UTILISATEUR A FIREBASE
        await _firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        log("Professionel Ajouté");

        // ADD DEVICE TOKEN
        NotificationServices().saveTokenAndId(
          collection: 'professionalToken',
          doc: credential.user!.uid,
          token: professionaltoken,
          userId: credential.user!.uid,
        );
        log("TOKEN ENVOYEE");

        NotificationServices().saveNotificationToFirestore(
          notificationId: credential.user!.uid,
          body: '$prenom $nom vous a envoyé une demande de création de compte',
          title: 'Demande de creation de compte',
        );
        log("NOTIFICATION PUSH TO FIREBASE");

        response = "success";
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
