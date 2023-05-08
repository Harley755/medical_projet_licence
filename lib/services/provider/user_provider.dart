import 'package:flutter/cupertino.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_methods.dart';

class UserProvider with ChangeNotifier {
  model.User? _user;
  final UserMethods _authMethods = UserMethods();

  model.User get getUser => _user!;

  // Future<void> refreshUser() async {
  //   User user = await _authMethods.getUserDetails();
  //   _user = user;
  //   notifyListeners();
  // }

  // Future<void> refreshUser() async {
  //   try {
  //     model.User user = await _authMethods.getUserIdentityDetails();
  //     _user = user;
  //     notifyListeners();
  //   } catch (e) {
  //     // Gérer l'erreur ici
  //     print(
  //         "Erreur lors de la récupération des détails de l'utilisateur : ${e.toString()}");
  //     // Vous pouvez également afficher un message d'erreur à l'utilisateur ou effectuer d'autres actions en conséquence.
  //   }
  // }
}
