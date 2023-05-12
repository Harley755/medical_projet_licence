import 'package:cloud_firestore/cloud_firestore.dart';

class Compte {
  final String compteId;
  final String nom;
  final String prenom;
  final String email;
  final String compteType;
  final String userId;

  const Compte({
    required this.compteId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.compteType,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'compteId': compteId,
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'compteType': compteType,
        'userId': userId,
      };

  static Compte fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Compte(
      compteId: snapshot['compteId'],
      nom: snapshot['nom'],
      prenom: snapshot['prenom'],
      email: snapshot['email'],
      compteType: snapshot['compteType'],
      userId: snapshot['userId'],
    );
  }
}
