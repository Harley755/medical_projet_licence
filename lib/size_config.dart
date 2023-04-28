import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// OBTENIR LA HAUTEUR PROPOTIONNELLE A LA TAILLE DE L'ECRAN
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 est la hauteur de la mise en page utilisée par le designer
  return (inputHeight / 812.0) * screenHeight;
}

// OBTENIR LA LARGEUR PROPOTIONNELLE A LA TAILLE DE L'ECRAN
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 812 est la hauteur de la mise en page utilisée par le designer
  return (inputWidth / 375.0) * screenWidth;
}
