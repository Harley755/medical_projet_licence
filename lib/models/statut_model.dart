import 'package:cloud_firestore/cloud_firestore.dart';

class Statut {
  final String statutId;
  final bool estAccepte;
  final String motif;
  final DateTime createdAt;
  final String userId;
  final String compteId;

  const Statut({
    required this.statutId,
    required this.estAccepte,
    required this.motif,
    required this.createdAt,
    required this.userId,
    required this.compteId,
  });

  Map<String, dynamic> toJson() => {
        'statutId': statutId,
        'estAccepte': estAccepte,
        'motif': motif,
        'createdAt': createdAt,
        'userId': userId,
        'compteId': compteId,
      };

  static Statut fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Statut(
      statutId: snapshot['statutId'],
      estAccepte: snapshot['estAccepte'],
      motif: snapshot['motif'],
      createdAt: snapshot['createdAt'],
      userId: snapshot['userId'],
      compteId: snapshot['compteId'],
    );
  }
}
