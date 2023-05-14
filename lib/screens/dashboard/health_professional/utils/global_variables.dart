import 'package:flutter/material.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/get_information/professional_get_page.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/professional_search_page.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/professional_profile_page.dart';

const TextStyle optionStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
);

List<Widget> professionalScreenItems = [
  const ProfessionalGetPage(),
  const ProfessionalSearchPage(),
  const ProfessionalProfilePage(),
];
