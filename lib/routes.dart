import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/auth_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/sign_up_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  AuthScreen.routeName: (context) => const AuthScreen(),

  // AUTH ACCOUNT SIGN_UP
  InfoSignUpScreen.routeName: (context) => const InfoSignUpScreen(),
  InfoSignInScreen.routeName: (context) => const InfoSignInScreen(),

  // AUTH ACCOUNT SIGN_IN
  MedicalSignUpScreen.routeName: (context) => const MedicalSignUpScreen(),
  MedicalSignInScreen.routeName: (context) => const MedicalSignInScreen(),
};
