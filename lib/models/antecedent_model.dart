import 'package:cloud_firestore/cloud_firestore.dart';

class Antecedent {
  final String antecedentId;
  final String antecedentMedicaux;
  final String maladiesChronique;
  final String antecedentTraumatique;
  final String antecedentAllergique;
  final String antecedentChirurgie;
  final String antecedentMaladieInfecteuse;
  final String userId;

  const Antecedent({
    required this.antecedentId,
    required this.antecedentMedicaux,
    required this.maladiesChronique,
    required this.antecedentTraumatique,
    required this.antecedentAllergique,
    required this.antecedentChirurgie,
    required this.antecedentMaladieInfecteuse,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'antecedentId': antecedentId,
        'antecedentMedicaux': antecedentMedicaux,
        'maladiesChronique': maladiesChronique,
        'antecedentTraumatique': antecedentTraumatique,
        'antecedentAllergique': antecedentAllergique,
        'antecedentChirurgie': antecedentChirurgie,
        'antecedentMaladieInfecteuse': antecedentMaladieInfecteuse,
        'userId': userId,
      };

  static Antecedent fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Antecedent(
      antecedentId: snapshot['antecedentId'],
      antecedentMedicaux: snapshot['antecedentMedicaux'],
      maladiesChronique: snapshot['maladiesChronique'],
      antecedentTraumatique: snapshot['antecedentTraumatique'],
      antecedentAllergique: snapshot['antecedentAllergique'],
      antecedentChirurgie: snapshot['antecedentChirurgie'],
      antecedentMaladieInfecteuse: snapshot['antecedentMaladieInfecteuse'],
      userId: snapshot['userId'],
    );
  }
}
