import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medical_projet/routes.dart';
import 'package:medical_projet/screens/auth/auth_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/sign_up_screen.dart';
import 'package:medical_projet/screens/dashboard/user/components/user_navigation_bar.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/user_medical_page.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/user_profile_page.dart';
import 'package:medical_projet/screens/dashboard/users_dashboard.dart';
import 'package:medical_projet/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Assistance App',
      theme: theme(),
      home: const UsersDashboardScreen(),
      // initialRoute: AuthScreen.routeName,
      routes: routes,
    );
  }
}
