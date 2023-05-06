import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';

class FingerPrintWay extends StatefulWidget {
  const FingerPrintWay({super.key});

  @override
  State<FingerPrintWay> createState() => _FingerPrintWayState();
}

class _FingerPrintWayState extends State<FingerPrintWay> {
  final _isFingerprintEnable = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.18),
          SvgPicture.asset(
            "assets/icons/fingerprint.svg",
            height: 100.0,
            color: kSecondaryColor,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          _isFingerprintEnable
              ? RobotoFont(
                  title:
                      "Veuillez toucher votre identifiant tactile pour un accès plus rapide et plus facile aux informations relatives à vos patients.",
                  size: getProportionateScreenWidth(14),
                  textAlign: TextAlign.center,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w700,
                )
              : RobotoFont(
                  title:
                      "Votre téléphophe ne dispose pas d'un lecteur d'emprunte digital.",
                  size: getProportionateScreenWidth(16),
                  textAlign: TextAlign.center,
                  color: Colors.red.withOpacity(0.9),
                  fontWeight: FontWeight.w700,
                ),
        ],
      ),
    );
  }
}
