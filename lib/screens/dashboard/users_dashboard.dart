import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/components/user_navigation_bar.dart';
import 'package:medical_projet/size_config.dart';

class UsersDashboardScreen extends StatefulWidget {
  static String routeName = "/users_dashboard";
  const UsersDashboardScreen({super.key});

  @override
  State<UsersDashboardScreen> createState() => _UsersDashboardScreenState();
}

class _UsersDashboardScreenState extends State<UsersDashboardScreen> {
  final int role = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return role == 1 ? const UserNavigationBar() : const Placeholder();
  }
}
