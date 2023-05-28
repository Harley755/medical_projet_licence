import 'package:cloud_firestore/cloud_firestore.dart';

class Statut {
  final String statutId;
  final String etatStatut;
  final String motif;
  final createdAt;
  final String userId;
  final String compteId;

  const Statut({
    required this.statutId,
    required this.etatStatut,
    required this.motif,
    required this.createdAt,
    required this.userId,
    required this.compteId,
  });

  Map<String, dynamic> toJson() => {
        'statutId': statutId,
        'etatStatut': etatStatut,
        'motif': motif,
        'createdAt': createdAt,
        'userId': userId,
        'compteId': compteId,
      };

  static Statut fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Statut(
      statutId: snapshot['statutId'],
      etatStatut: snapshot['etatStatut'],
      motif: snapshot['motif'],
      createdAt: snapshot['createdAt'],
      userId: snapshot['userId'],
      compteId: snapshot['compteId'],
    );
  }
}
