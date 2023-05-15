import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/dashboard/administrator/components/admin_navigation_bar.dart';
import 'package:medical_projet/screens/dashboard/health_professional/components/professional_navigation_bar.dart';
import 'package:medical_projet/screens/dashboard/user/components/user_navigation_bar.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class UsersDashboardScreen extends StatefulWidget {
  static String routeName = "/users_dashboard";
  const UsersDashboardScreen({super.key});

  @override
  State<UsersDashboardScreen> createState() => _UsersDashboardScreenState();
}

class _UsersDashboardScreenState extends State<UsersDashboardScreen> {
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
      // _userRoleFuture.then((user) {
      //   setState(() {
      //     _user = user;
      //     _role = _user!.role;
      //     _hasTwoAccount = _user!.hasTwoAccount;
      //   });
      // });
    }
    super.initState();
  }

  Widget getNavigationBar() {
    switch (_role) {
      case 'user':
        return const UserNavigationBar();
        break;
      case 'professional':
        return const ProfessionalNavigationBar();
        break;
      case 'admin':
        return const AdminNavigationBar();
        break;
      default:
        return const SizedBox();
    }
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
