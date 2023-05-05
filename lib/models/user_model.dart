import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String nom;
  final String prenom;
  final String email;
  final String photoUrl;
  final String telephone;
  final String groupeSanguinId;
  final String nomContactUrgence;
  final String telephoneContactUrgence;

  const User({
    required this.userId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.photoUrl,
    required this.telephone,
    required this.groupeSanguinId,
    required this.nomContactUrgence,
    required this.telephoneContactUrgence,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'photoUrl': photoUrl,
        'telephone': telephone,
        'groupeSanguinId': groupeSanguinId,
        'nomContactUrgence': nomContactUrgence,
        'telephoneContactUrgence': telephoneContactUrgence,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      userId: snapshot['userId'],
      nom: snapshot['nom'],
      prenom: snapshot['prenom'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      telephone: snapshot['telephone'],
      groupeSanguinId: snapshot['groupeSanguinId'],
      nomContactUrgence: snapshot['nomContactUrgence'],
      telephoneContactUrgence: snapshot['telephoneContactUrgence'],
    );
  }
}
