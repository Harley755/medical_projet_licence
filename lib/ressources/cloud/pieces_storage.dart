import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PiecesStorage {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadPieces(
      {required String uid,
      required String pieceName,
      required String piecePath}) async {
    final storageRef =
        _storage.ref().child('pieces').child(uid).child(pieceName);
    final uploadTask = storageRef.putFile(File(piecePath));
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
