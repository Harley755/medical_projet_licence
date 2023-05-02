import 'package:flutter/material.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/get_information/facial_recognition/facial_recognition_way.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/get_information/finger_print/fingerprint_way.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/get_information/iris_recognition%20copy/iris_recognition_way.dart';
import 'package:medical_projet/size_config.dart';

class ProfessionalGetWay extends StatefulWidget {
  const ProfessionalGetWay({super.key});

  @override
  State<ProfessionalGetWay> createState() => _ProfessionalGetWayState();
}

class _ProfessionalGetWayState extends State<ProfessionalGetWay> {
  List<String> tabGetWayMenus = [
    'Empreinte\nDigitale',
    'Reconnaissance\nFaciale',
    'Reconnaissance\nd\'Iris',
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          SizedBox(
            height: 67.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabGetWayMenus.length,
              itemBuilder: (context, index) => buildProfessionalGetWay(index),
            ),
          ),
          selectedIndex == 0
              ? const FingerPrintWay()
              : selectedIndex == 1
                  ? const FacialRecognitionWay()
                  : const IrisRecognitionWay()
        ],
      ),
    );
  }

  Widget buildProfessionalGetWay(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          print(selectedIndex);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(17),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tabGetWayMenus[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kPrimaryColor : kSecondaryColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: getProportionateScreenWidth(20) / 4),
              height: 7.0,
              width: 7.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    selectedIndex == index ? kPrimaryColor : Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
