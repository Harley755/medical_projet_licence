import 'package:cloud_firestore/cloud_firestore.dart';

class Compte {
  final String compteId;
  final String nom;
  final String prenom;
  final String email;
  final String compteType;
  final String photoUrl;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Compte({
    required this.compteId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.compteType,
    required this.photoUrl,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'compteId': compteId,
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'compteType': compteType,
        'photoUrl': photoUrl,
        'userId': userId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  static Compte fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Compte(
      compteId: snapshot['compteId'],
      nom: snapshot['nom'],
      prenom: snapshot['prenom'],
      email: snapshot['email'],
      compteType: snapshot['compteType'],
      photoUrl: snapshot['photoUrl'],
      userId: snapshot['userId'],
      createdAt: snapshot['createdAt'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
