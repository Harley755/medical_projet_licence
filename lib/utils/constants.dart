import 'package:flutter/material.dart';
import 'package:medical_projet/size_config.dart';

// const kPrimaryColor = Colors.teal;
// const kPrimaryColor = Color.fromARGB(255, 187, 69, 255);
const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
final selectTabBg = Colors.amber[600]!.withOpacity(.2);

const kSecondaryColor = Color(0xFF979797);
const kUserResColor = Color.fromARGB(255, 77, 77, 77);
const kTextColor = Color(0xFF757575);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(26),
  fontWeight: FontWeight.w400,
  color: Colors.black,
  height: 1.5,
);

ThemeData focusedTheme = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kPrimaryColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: kPrimaryColor),
    prefixStyle: TextStyle(color: kPrimaryColor),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
  ),
);

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.+]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Veuillez entrer votre email";
const String kInvalidEmailError = "Veuillez entrer une email valide";

const String kPassEmpty = "";
const String kPassNullError = "Veuillez entrer votre mot de passe";
const String kShortPassError = "Mot de passe trop court";
// const String kMatchPassError = "Passwords don't match";

// USER IDENTITY FIELD ERROR
const String kLastNameNullError = "Veuillez entrer votre nom";
const String kFirstNameNullError = "Veuillez entrer votre prénom";
const String kPoidsNullError = "Veuillez entrer votre poids";
const String kAgeNullError = "Veuillez entrer votre age";
const String kSexeNullError = "Veuillez choisir votre sexe";
const String kEmergenceNameNullError = "Veuillez entrer le nom";
const String kEmergenceContactNullError = "Veuillez entrer le contact";
const String kEmergenceRelationshipNullError =
    "Veuillez entrer le type de relation";
const String kBirthDayNullError = "Veuillez entrer le contact";

// USER MEDICAL FIELD ERROR
// ANTECEDENTS MEDICAUX
const String kBloodTypeNullError = "Veuillez choisir votre groupe sanguin";
const String kFamilyMedicalHistoryNullError = "Antécédents médicaux familiaux";
const String kChronicIllnessesNullError = "Maladies chroniques";
const String kHistorySevereAllergicReactionsNullError =
    "Antécédents de réactions allergiques graves";
const String kHistoryOfTraumaNullError = "Antécédents de traumatismes";
const String kHistoryOfRecentSurgeryNullError =
    "Antécédents de chirurgie récente";
const String kHistoryOfInfectiousDiseasesNullError =
    "Antécédents de maladies infectieuses";

// MEDICAMENTS
const String kListOfCurrentMedicationsNullError =
    "Liste des médicaments en cours";
const String kDosageScheduleCurrentMedicationsNullError =
    "Dosage et horaires de prise des médicaments en cours";
const String kKnownFoodAllergiesNullError = "Allergies alimentaires connues";
const String kKnownSevereAllergicNullError =
    "Réactions allergiques graves connues à des médicaments ou à des substances";

const String kPhoneNumberNullError =
    "Veuillez entrer votre numéro de téléphone";

const String kSpecialityNullError = "Veuillez entrer votre specialité";

// ADMIN
const String kSecretCodeNullError = "Veuillez entrer votre code secret";
