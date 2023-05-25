import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/auth/finger_print/finger_print.dart';
import 'package:medical_projet/screens/dashboard/administrator/components/admin_navigation_bar.dart';
import 'package:medical_projet/screens/dashboard/health_professional/components/professional_navigation_bar.dart';
import 'package:medical_projet/screens/dashboard/user/components/user_navigation_bar.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UsersDashboardScreen extends StatefulWidget {
  static String routeName = "/users_dashboard";

  const UsersDashboardScreen({Key? key}) : super(key: key);

  @override
  State<UsersDashboardScreen> createState() => _UsersDashboardScreenState();
}

class _UsersDashboardScreenState extends State<UsersDashboardScreen> {
  bool isAuthorized = false;
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<model.User> _userRoleFuture;
  model.User? _user;
  String _role = "";

  @override
  void initState() {
    if (currentUser != null) {
      _userRoleFuture = UserAuthMethods().getUserIdentityDetails(
        userId: currentUser!.uid,
      );
    }
    super.initState();
  }

  void handleAuthorizationComplete(bool authorized) {
    setState(() {
      isAuthorized = authorized;
    });
  }

  Widget getNavigationBar() {
    if (_role == 'user') {
      return const UserNavigationBar();
    } else if (_role == 'professional') {
      return const ProfessionalNavigationBar();
    } else if (_role == 'admin') {
      return const AdminNavigationBar();
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return FutureBuilder<model.User>(
      future: _userRoleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          _user = snapshot.data!;
          _role = _user!.role;

          return getNavigationBar();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Erreur de chargement des données'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
