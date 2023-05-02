import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/user/pages/home/user_home_page.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/user_medical_page.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/user_profile_page.dart';

const TextStyle optionStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
);

List<Widget> userScreenItems = [
  const UserHomePage(),
  const UserMedicalPage(),
  const UserMedicalPage(),
  const UserProfilePage(),
];
