import 'package:cloud_firestore/cloud_firestore.dart';

class Professional {
  final String userId;
  final String nom;
  final String prenom;
  final String email;
  final String specialite;
  final String photoUrl;
  final String photoCarteMedicale;
  final String photoPieceIdentite;
  final String telephone;
  final String role;

  const Professional({
    required this.userId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.specialite,
    required this.photoUrl,
    required this.photoCarteMedicale,
    required this.photoPieceIdentite,
    required this.telephone,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'specialite': specialite,
        'photoUrl': photoUrl,
        'photoCarteMedicale': photoCarteMedicale,
        'photoPieceIdentite': photoPieceIdentite,
        'telephone': telephone,
        'role': role,
      };

  static Professional fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Professional(
      userId: snapshot['userId'],
      nom: snapshot['nom'],
      prenom: snapshot['prenom'],
      email: snapshot['email'],
      specialite: snapshot['specialite'],
      telephone: snapshot['telephone'],
      photoCarteMedicale: snapshot['photoCarteMedicale'],
      photoPieceIdentite: snapshot['photoPieceIdentite'],
      photoUrl: snapshot['photoUrl'],
      role: snapshot['role'],
    );
  }
}
