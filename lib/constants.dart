import 'package:flutter/material.dart';
import 'package:medical_projet/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);

const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(26),
  fontWeight: FontWeight.w400,
  color: Colors.black,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Veuillez entrer votre email";
const String kInvalidEmailError = "Veuillez entrer une email valide";

const String kPassEmpty = "";
const String kPassNullError = "Veuillez entrer votre mot de passe";
const String kShortPassError = "Mot de passe trop court";
// const String kMatchPassError = "Passwords don't match";

const String kLastNameNullError = "Veuillez entrer votre nom";
const String kFirstNameNullError = "Veuillez entrer votre prénom";

const String kSpecialityNullError = "Veuillez entrer votre specialité";

const String kPhoneNumberNullError =
    "Veuillez entrer votre numéro de téléphone";