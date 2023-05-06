import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/ressources/auth/user_methods.dart';
import 'package:medical_projet/screens/dashboard/users_dashboard.dart';

class UserSendEmailVerification extends StatefulWidget {
  const UserSendEmailVerification({super.key});

  @override
  State<UserSendEmailVerification> createState() =>
      _UserSendEmailVerificationState();
}

class _UserSendEmailVerificationState extends State<UserSendEmailVerification> {
  bool isEmailVerified = false;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body: isEmailVerified
          ? const UsersDashboardScreen()
          : SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "W've sent you an email verification. Please open it to verify your account.",
                  ),
                  const Text(
                    "If you haven't received a verification email yet, press the button below",
                  ),
                  TextButton(
                    onPressed: () => UserMethods().sendEmailVerification(),
                    child: const Text('Send email verification'),
                  ),
                  // TextButton(
                  //   onPressed: () {

                  //   },
                  //   child: const Text('Restart'),
                  // )
                ],
              ),
            ),
    );
  }
}
