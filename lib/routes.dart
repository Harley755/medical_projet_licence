import 'package:flutter/material.dart';
import 'package:medical_projet/screens/auth/auth_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/sign_up_screen.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/components/otp_verification.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/user_otp.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_in/sign_in_screen.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/sign_up_screen.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/auth/sign_up/admin_sign_up.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/admin_chat_page.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/chat/components/admin_chat_page_body.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/detail_page.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/professional_search_page.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/associated_account/associated_account.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/identity/professional_modfy_profile/professional_modify_profile.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/identity/professional_profile_identity.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/profile/professional_profile_page.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/components/user_medical_modify/user_medical_modify.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/user_medical_page.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/associated_account/associated_account.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/associated_account/new_signup_account/new_signup.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_modfy_profile/user_profile_identity_modify.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_profile_identity.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/medical/inter_screens/inter_screens.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/medical/medical_account.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/security/change_email/user_change_email.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/security/change_password/user_change_password.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/sign_in/account_sign_in_screen.dart';
import 'package:medical_projet/screens/dashboard/users_dashboard.dart';

import 'screens/dashboard/administrator/pages/chat/components/details_conversation.dart';
import 'screens/dashboard/user/pages/profile/user_profile_page.dart';

final Map<String, WidgetBuilder> routes = {
  AuthScreen.routeName: (context) => const AuthScreen(),

  // AUTH ACCOUNT SIGN_UP
  InfoSignUpScreen.routeName: (context) => const InfoSignUpScreen(),
  InfoSignInScreen.routeName: (context) => const InfoSignInScreen(),

  OtpVerification.routeName: (context) => const OtpVerification(),

  // AUTH ACCOUNT SIGN_IN
  MedicalSignUpScreen.routeName: (context) => const MedicalSignUpScreen(),
  MedicalSignInScreen.routeName: (context) => const MedicalSignInScreen(),

  // USER DASHBOARD CHOICE
  UsersDashboardScreen.routeName: (context) => const UsersDashboardScreen(),

  // USER PROFILE
  // identity form
  UserProfileIdentity.routeName: (context) => const UserProfileIdentity(),
  // modify
  UserProfileIdentityModify.routeName: (context) =>
      const UserProfileIdentityModify(),
  // profile screen
  UserProfilePage.routeName: (context) => const UserProfilePage(),
  // medical page
  UserMedicalPage.routeName: (context) => const UserMedicalPage(),
  UserMedicalModify.routeName: (context) => const UserMedicalModify(),
  // ASSOCIATED ACCOUNT
  AssociatedAccount.routeName: (context) => const AssociatedAccount(),
  NewSignUp.routeName: (context) => const NewSignUp(),
  UserChangeEmail.routeName: (context) => const UserChangeEmail(),
  UserChangePassword.routeName: (context) => const UserChangePassword(),

  MedicalAccount.routeName: (context) => const MedicalAccount(),
  InterScreens.routeName: (context) => const InterScreens(),

  // MEDICAL PROFESSIONAL
  // identity form
  ProfessionalProfileIdentity.routeName: (context) =>
      const ProfessionalProfileIdentity(),
  // profile screen
  ProfessionalProfilePage.routeName: (context) =>
      const ProfessionalProfilePage(),
  // medical page
  ProfessionalSearchPage.routeName: (context) => const ProfessionalSearchPage(),
  // DetailPage.routeName: (context) => const DetailPage(),
  ProfessionalModifyProfile.routeName: (context) =>
      const ProfessionalModifyProfile(),
  ProfessionalAssociatedAccount.routeName: (context) =>
      const ProfessionalAssociatedAccount(),

  // ADMIN
  AdminSignUpScreen.routeName: (context) => const AdminSignUpScreen(),
  AdminDetailConversation.routeName: (context) =>
      const AdminDetailConversation(),
  AdminChatPage.routeName: (context) => const AdminChatPage(),
};
