import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/models/professional_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/fileInput/file_input_controller.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ProfessionalProfileFormReadOnly extends StatefulWidget {
  const ProfessionalProfileFormReadOnly({super.key});

  @override
  State<ProfessionalProfileFormReadOnly> createState() =>
      _ProfessionalProfileFormReadOnlyState();
}

class _ProfessionalProfileFormReadOnlyState
    extends State<ProfessionalProfileFormReadOnly> {
  final _fileMedicalInputController = FileInputController();
  final _fileIdentiteInputController = FileInputController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<model.Professional> _userDetailsFuture;
  model.Professional? _professional;

  String _nom = "";
  List<String> _prenom = [];
  String _specialite = "";
  String? _photoCarteMedicale = "";
  String? _photoPieceIdentite = "";

  @override
  void initState() {
    if (currentUser != null) {
      _userDetailsFuture = UserAuthMethods().getProfessionalIdentityDetails(
        userId: currentUser!.uid,
      );
      _userDetailsFuture.then((professional) {
        setState(() {
          _professional = professional;
          print(_professional!.nom);
          _nom = _professional!.nom;
          _prenom = _professional!.prenom;
          // _telephone = _professional!.specialite;
          _photoCarteMedicale = _professional!.photoCarteMedicale;
          _photoCarteMedicale = _professional!.photoPieceIdentite;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IDENTITY
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildInputIdentiteField(_fileIdentiteInputController),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSpecialityFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildInputMedicalField(_fileMedicalInputController),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  FileInputField buildInputMedicalField(
    FileInputController fileMedicalInputController,
  ) {
    return FileInputField(
      labelText: 'Carte Médicale',
      controller: fileMedicalInputController,
      press: () async {},
    );
  }

  FileInputField buildInputIdentiteField(
    FileInputController fileIdentiteInputController,
  ) {
    return FileInputField(
      labelText: 'Piece d\'identité',
      controller: fileIdentiteInputController,
      press: () async {},
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = _nom,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: "Nom",
        hintText: "Entrer votre nom",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(icon: Icons.person_outlined),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    String prenomText = _prenom.join(' ');
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = prenomText,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: "Prénoms",
        hintText: "Entrer vos prénoms",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(icon: Icons.person_outlined),
      ),
    );
  }

  TextFormField buildSpecialityFormField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = _specialite,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: "Spécialité",
        hintText: "Entrer votre spécialité",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(icon: Icons.medical_information_outlined),
      ),
    );
  }

  // TextFormField buildConformPassFormField() {
  //   return TextFormField(
  //     obscureText: true,
  //     onSaved: (newValue) => conformPassword = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kPassNullError);
  //       } else if (value.isNotEmpty && password == conformPassword) {
  //         removeError(error: kMatchPassError);
  //       }
  //       conformPassword = value;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kPassNullError);
  //         return "";
  //       } else if ((password != value)) {
  //         addError(error: kMatchPassError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: const InputDecoration(
  //       labelText: "Confirm Password",
  //       hintText: "Re-enter your password",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
  //     ),
  //   );
  // }
}
