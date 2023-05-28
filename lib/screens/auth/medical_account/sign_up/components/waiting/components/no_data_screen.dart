import 'package:flutter/material.dart';
import 'package:medical_projet/utils/constants.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
