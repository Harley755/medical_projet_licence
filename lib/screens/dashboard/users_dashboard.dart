import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/administrator/components/admin_navigation_bar.dart';
import 'package:medical_projet/screens/dashboard/health_professional/components/professional_navigation_bar.dart';
import 'package:medical_projet/screens/dashboard/user/components/user_navigation_bar.dart';
import 'package:medical_projet/size_config.dart';

class UsersDashboardScreen extends StatefulWidget {
  static String routeName = "/users_dashboard";
  const UsersDashboardScreen({super.key});

  @override
  State<UsersDashboardScreen> createState() => _UsersDashboardScreenState();
}

class _UsersDashboardScreenState extends State<UsersDashboardScreen> {
  int isUser = 1;
  int isHealthProfesssional = 0;
  int isAdmin = 3;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isUser == 1
        ? const UserNavigationBar()
        : isHealthProfesssional == 2
            ? const ProfessionalNavigationBar()
            : const AdminNavigationBar();

    // return const UserNavigationBar();
  }
}
