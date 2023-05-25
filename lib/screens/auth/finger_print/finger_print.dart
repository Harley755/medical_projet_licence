import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class FingerPrint extends StatefulWidget {
  final Function(bool) onAuthorizationComplete;

  const FingerPrint({
    Key? key,
    required this.onAuthorizationComplete,
  }) : super(key: key);

  @override
  State<FingerPrint> createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    authenticateMe();
  }

  Future<void> authenticateMe() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticate(
        localizedReason: 'Veuillez vous authentifier pour continuer',
        options: const AuthenticationOptions(
          biometricOnly: false,
          sensitiveTransaction: false,
          stickyAuth: true,
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Oops! L\'authentification est requise !',
            cancelButton: '',
          ),
          IOSAuthMessages(
            cancelButton: '',
          ),
        ],
      );
    } on PlatformException catch (e) {
      log(e.toString());
    }
    if (!mounted) return;

    if (authenticated) {
      setState(() {
        widget.onAuthorizationComplete(authenticated);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
