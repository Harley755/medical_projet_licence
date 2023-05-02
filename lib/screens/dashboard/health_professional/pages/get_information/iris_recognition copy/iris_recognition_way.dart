import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';

class IrisRecognitionWay extends StatefulWidget {
  const IrisRecognitionWay({super.key});

  @override
  State<IrisRecognitionWay> createState() => _IrisRecognitionWayState();
}

class _IrisRecognitionWayState extends State<IrisRecognitionWay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RobotoFont(title: "Iris Recognition".toUpperCase(), size: 17.0),
    );
  }
}
