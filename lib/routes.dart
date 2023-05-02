import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/auth_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/sign_up_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/sign_up_screen.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/professional_medical_page.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/identity/professional_profile_identity.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/professional_profile_page.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/user_medical_page.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_profile_identity.dart';
import 'package:medical_projet/screens/dashboard/users_dashboard.dart';

import 'screens/dashboard/user/pages/profile/user_profile_page.dart';

final Map<String, WidgetBuilder> routes = {
  AuthScreen.routeName: (context) => const AuthScreen(),

  // AUTH ACCOUNT SIGN_UP
  InfoSignUpScreen.routeName: (context) => const InfoSignUpScreen(),
  InfoSignInScreen.routeName: (context) => const InfoSignInScreen(),

  // AUTH ACCOUNT SIGN_IN
  MedicalSignUpScreen.routeName: (context) => const MedicalSignUpScreen(),
  MedicalSignInScreen.routeName: (context) => const MedicalSignInScreen(),

  // USER DASHBOARD CHOICE
  UsersDashboardScreen.routeName: (context) => const UsersDashboardScreen(),

  // USER PROFILE
  // identity form
  UserProfileIdentity.routeName: (context) => const UserProfileIdentity(),
  // profile screen
  UserProfilePage.routeName: (context) => const UserProfilePage(),
  // medical page
  UserMedicalPage.routeName: (context) => const UserMedicalPage(),

  // MEDICAL PROFESSIONAL
  // identity form
  ProfessionalProfileIdentity.routeName: (context) =>
      const ProfessionalProfileIdentity(),
  // profile screen
  ProfessionalProfilePage.routeName: (context) =>
      const ProfessionalProfilePage(),
  // medical page
  ProfessionalMedicalPage.routeName: (context) =>
      const ProfessionalMedicalPage(),
};
