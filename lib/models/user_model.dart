import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String nom;
  final String prenom;
  final String email;
  final String poids;
  final String sexe;
  final String age;
  final String photoUrl;
  final String telephone;
  final String groupeSanguinId;
  final String nomContactUrgence;
  final String telephoneContactUrgence;
  final String relation;
  final bool hasTwoAccount;
  final String role;

  const User({
    required this.userId,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.poids,
    required this.sexe,
    required this.age,
    required this.photoUrl,
    required this.telephone,
    required this.groupeSanguinId,
    required this.nomContactUrgence,
    required this.telephoneContactUrgence,
    required this.relation,
    this.hasTwoAccount = false,
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
        'photoUrl': photoUrl,
        'telephone': telephone,
        'groupeSanguinId': groupeSanguinId,
        'nomContactUrgence': nomContactUrgence,
        'telephoneContactUrgence': telephoneContactUrgence,
        'relation': relation,
        'hasTwoAccount': hasTwoAccount,
        'role': role,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      userId: snapshot['userId'],
      nom: snapshot['nom'],
      prenom: snapshot['prenom'],
      poids: snapshot['poids'],
      sexe: snapshot['sexe'],
      age: snapshot['age'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      telephone: snapshot['telephone'],
      groupeSanguinId: snapshot['groupeSanguinId'],
      nomContactUrgence: snapshot['nomContactUrgence'],
      telephoneContactUrgence: snapshot['telephoneContactUrgence'],
      relation: snapshot['relation'],
      hasTwoAccount: snapshot['hasTwoAccount'],
      role: snapshot['role'],
    );
  }
}
