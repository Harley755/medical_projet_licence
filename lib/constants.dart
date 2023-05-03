import 'package:flutter/material.dart';
import 'package:medical_projet/size_config.dart';

// const kPrimaryColor = Colors.teal;
const kPrimaryColor = Color.fromARGB(255, 187, 69, 255);
const kPrimaryLightColor = Color(0xFFFFECDF);
final selectTabBg = Colors.amber[600]!.withOpacity(.2);

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

// USER IDENTITY FIELD ERROR
const String kLastNameNullError = "Veuillez entrer votre nom";
const String kFirstNameNullError = "Veuillez entrer votre prénom";
const String kPoidsNullError = "Veuillez entrer votre poids";
const String kSexeNullError = "Veuillez choisir votre sexe";
const String kEmergenceNameNullError = "Veuillez entrer le nom";
const String kEmergenceContactNullError = "Veuillez entrer le contact";
const String kEmergenceRelationshipNullError =
    "Veuillez entrer le type de relation";

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
