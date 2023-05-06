import 'package:flutter/cupertino.dart';
import 'package:medical_projet/models/user_model.dart';
import 'package:medical_projet/ressources/auth/user_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final UserMethods _authMethods = UserMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
