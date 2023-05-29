import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String nom;
  final List<String> prenom;
  final String email;
  final String? poids;
  final String? sexe;
  final String? age;
  final String? dateNaissance;
  final String? photoUrl;
  final String? telephone;
  final String? groupeSanguinId;
  final String? nomContactUrgence;
  final String? telephoneContactUrgence;
  final String? relation;
  final String role;

  const User({
    required this.userId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.poids,
    required this.sexe,
    required this.age,
    required this.dateNaissance,
    required this.photoUrl,
    required this.telephone,
    required this.groupeSanguinId,
    required this.nomContactUrgence,
    required this.telephoneContactUrgence,
    required this.relation,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'poids': poids,
        'sexe': sexe,
        'age': age,
        'dateNaissance': dateNaissance,
        'photoUrl': photoUrl,
        'telephone': telephone,
        'groupeSanguinId': groupeSanguinId,
        'nomContactUrgence': nomContactUrgence,
        'telephoneContactUrgence': telephoneContactUrgence,
        'relation': relation,
        'role': role,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      userId: snapshot['userId'],
      nom: snapshot['nom'],
      prenom: List<String>.from(snapshot['prenom'] ?? []),
      poids: snapshot['poids'],
      sexe: snapshot['sexe'],
      age: snapshot['age'],
      dateNaissance: snapshot['dateNaissance'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      telephone: snapshot['telephone'],
      groupeSanguinId: snapshot['groupeSanguinId'],
      nomContactUrgence: snapshot['nomContactUrgence'],
      telephoneContactUrgence: snapshot['telephoneContactUrgence'],
      relation: snapshot['relation'],
      role: snapshot['role'],
    );
  }
}
