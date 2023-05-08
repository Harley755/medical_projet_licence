import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_profile_identity.dart';
import 'package:medical_projet/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProfileFormReadOnly extends StatefulWidget {
  const UserProfileFormReadOnly({super.key});

  @override
  State<UserProfileFormReadOnly> createState() =>
      _UserProfileFormReadOnlyState();
}

class _UserProfileFormReadOnlyState extends State<UserProfileFormReadOnly> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<model.User> _userDetailsFuture;
  model.User? _user;

  String _nom = "";
  String _prenom = "";
  String _sexe = "";
  String _poids = "";
  String _nomContactUrgence = "";
  String _telephoneContactUrgence = "";

  @override
  void initState() {
    if (currentUser != null) {
      _userDetailsFuture = UserMethods().getUserIdentityDetails(
        currentUser!.uid,
      );
      _userDetailsFuture.then((user) {
        setState(() {
          _user = user;
          print(_user!.nom);
          _nom = _user!.nom;
          print(TextEditingController(text: _nom).toString());
          _prenom = _user!.prenom;
          _sexe = _user!.sexe;
          _poids = _user!.poids;
          _nomContactUrgence = _user!.nomContactUrgence;
          _telephoneContactUrgence = _user!.telephoneContactUrgence;
        });
      });
    }
    super.initState();
  }

// FOR MEDICAL'S USER
  // PERMET D'APPELER LE CONTACT CHOISIS, SI PAS DE CONTACT CA N'APPELLE PAS
  // void _callSelectedContact() async {
  //   // Vérifier si la permission d'accéder aux contacts a été accordée
  //   if (_selectedContact != null) {
  //     final Uri url = Uri.parse(
  //         'tel:${_selectedContact!.phones!.isNotEmpty ? _selectedContact!.phones!.first.value : ''}');
  //     if (await canLaunchUrl(url)) {
  //       await launchUrl(url);
  //     } else {
  //       print('Impossible de lancer l\'appel $url');
  //     }
  //   } else {
  //     print('Aucun contact sélectionné.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final List<String> genderItems = [
      'Masculin',
      'Féminin',
    ];

    String? selectedValue;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IDENTITY
          RobotoFont(
            title: 'Identité',
            size: getProportionateScreenWidth(22),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSexeFormField(genderItems, selectedValue),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPoidsFormField(),

          SizedBox(height: SizeConfig.screenHeight * 0.03),

          // CONTACT EN CAS D'URGENCE
          RobotoFont(
            title: 'Contact en cas d\'urgence',
            size: getProportionateScreenWidth(22),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),

          SizedBox(height: getProportionateScreenHeight(15)),
          buildEmergenceNameField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmergenceContactField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmergenceRelationshipField(),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  DropdownButtonFormField2<String> buildSexeFormField(
      List<String> genderItems, String? selectedValue) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: const Text(
        'Selectioner votre sexe',
        style: TextStyle(fontSize: 14),
      ),
      items: genderItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      onChanged: (value) {
        if (value == null) {}
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      readOnly: true,
      initialValue: _nom,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Nom",
        hintText: "Entrer votre nom",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPoidsFormField() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.number,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Poids",
        hintText: "Entrer votre poids",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmergenceNameField() {
    return TextFormField(
      readOnly: true,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Nom",
        hintText: "Entrer le nom",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmergenceContactField() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.phone,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Contact",
        hintText: "Entrer le contact",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Call.svg"),
      ),
    );
  }

  TextFormField buildEmergenceRelationshipField() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Relation",
        hintText: "Entrer le type de relation",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      readOnly: true,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Prénoms",
        hintText: "Entrer vos prénoms",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  // TextFormField buildEmailFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.emailAddress,
  //     onSaved: (newValue) => email = newValue,
  //     onChanged: (value) {
  //       atorRegExp.hasMatch(value)) {
  //         removeError(error: kInvalidEmailError);
  //       }
  //     },
  //     decoration: const InputDecoration(
  //       labelText: "Email",
  //       hintText: "Entrer votre adresse email",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
  //     ),
  //   );
  // }
}
