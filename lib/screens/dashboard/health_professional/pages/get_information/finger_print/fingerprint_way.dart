import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';

class FingerPrintWay extends StatefulWidget {
  const FingerPrintWay({super.key});

  @override
  State<FingerPrintWay> createState() => _FingerPrintWayState();
}

class _FingerPrintWayState extends State<FingerPrintWay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RobotoFont(title: "FingerPrint".toUpperCase(), size: 17.0),
    );
  }
}
