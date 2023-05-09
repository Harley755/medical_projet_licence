import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AntecedentMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> updateMedicalHistory({
    required antecedentMedicaux,
    required maladiesChronique,
    required antecedentTraumatique,
    required antecedentAllergique,
    required antecedentChirurgie,
    required antecedentMaladieInfecteuse,
  }) async {
    String response = "";
    User? currentUser = _auth.currentUser;
    try {
      if (antecedentMedicaux.isNotEmpty ||
          maladiesChronique.isNotEmpty ||
          antecedentTraumatique.isNotEmpty ||
          antecedentAllergique.isNotEmpty ||
          antecedentChirurgie.isNotEmpty ||
          antecedentMaladieInfecteuse.isNotEmpty) {
        final doc = await _firestore
            .collection('antecedents')
            .doc(currentUser!.uid)
            .get();
        if (doc.exists) {
          await _firestore
              .collection('antecedents')
              .doc(currentUser.uid)
              .update({
            'antecedentMedicaux': antecedentMedicaux,
            'maladiesChronique': maladiesChronique,
            'antecedentTraumatique': antecedentTraumatique,
            'antecedentAllergique': antecedentAllergique,
            'antecedentChirurgie': antecedentChirurgie,
            'antecedentMaladieInfecteuse': antecedentMaladieInfecteuse,
          });
        } else {
          await _firestore.collection('antecedents').doc(currentUser.uid).set({
            'antecedentId': currentUser.uid,
            'antecedentMedicaux': antecedentMedicaux,
            'maladiesChronique': maladiesChronique,
            'antecedentTraumatique': antecedentTraumatique,
            'antecedentAllergique': antecedentAllergique,
            'antecedentChirurgie': antecedentChirurgie,
            'antecedentMaladieInfecteuse': antecedentMaladieInfecteuse,
            'userId': currentUser.uid,
          });
        }
        response = "success";
      }
    } catch (e) {
      print(e);
    }
    return response;
  }
}
