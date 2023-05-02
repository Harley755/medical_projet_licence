import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';

class FacialRecognitionWay extends StatefulWidget {
  const FacialRecognitionWay({super.key});

  @override
  State<FacialRecognitionWay> createState() => _FacialRecognitionWayState();
}

class _FacialRecognitionWayState extends State<FacialRecognitionWay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RobotoFont(title: "Facial Recognition".toUpperCase(), size: 17.0),
    );
  }
}
