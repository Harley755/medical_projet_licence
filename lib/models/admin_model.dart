import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String userId;
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String secretCode;
  final String role;

  const Admin({
    required this.userId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.secretCode,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'telephone': telephone,
        'secretCode': secretCode,
        'role': role,
      };

  static Admin fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Admin(
      userId: snapshot['userId'],
      nom: snapshot['nom'],
      prenom: snapshot['prenom'],
      email: snapshot['email'],
      telephone: snapshot['telephone'],
      secretCode: snapshot['secretCode'],
      role: snapshot['role'],
    );
  }
}
