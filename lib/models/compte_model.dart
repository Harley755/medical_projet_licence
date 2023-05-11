import 'package:cloud_firestore/cloud_firestore.dart';

class Compte {
  final String compteId;
  final String email;
  final String compteType;
  final String userId;

  const Compte({
    required this.compteId,
    required this.email,
    required this.compteType,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'compteId': compteId,
        'email': email,
        'compteType': compteType,
        'userId': userId,
      };

  static Compte fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Compte(
      compteId: snapshot['compteId'],
      email: snapshot['email'],
      compteType: snapshot['compteType'],
      userId: snapshot['userId'],
    );
  }
}
