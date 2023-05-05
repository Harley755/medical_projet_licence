import 'package:cloud_firestore/cloud_firestore.dart';

class Compte {
  final String compteId;
  final String password;
  final String email;
  final String userId;

  const Compte({
    required this.compteId,
    required this.password,
    required this.email,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'compteId': compteId,
        'email': email,
        'password': password,
        'userId': userId,
      };

  static Compte fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Compte(
      compteId: snapshot['compteId'],
      userId: snapshot['userId'],
      email: snapshot['email'],
      password: snapshot['password'],
    );
  }
}
