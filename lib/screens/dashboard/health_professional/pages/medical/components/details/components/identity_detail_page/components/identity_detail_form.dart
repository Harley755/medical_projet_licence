import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class IdentityDetailFormReadOnly extends StatefulWidget {
  final String userId;
  const IdentityDetailFormReadOnly({super.key, required this.userId});

  @override
  State<IdentityDetailFormReadOnly> createState() =>
      _IdentityDetailFormReadOnlyState();
}

class _IdentityDetailFormReadOnlyState
    extends State<IdentityDetailFormReadOnly> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<model.User> _userDetailsFuture;
  model.User? _user;

  String _nom = "";
  List<String> _prenom = [];
  String? _sexe = "";
  String? _groupeSanguinId = "";
  String? _groupeSanguin = "";
  String? _poids = "";
  String? _age = "";
  String? _nomContactUrgence = "";
  String? _telephoneContactUrgence = "";
  String? _relation = "";

  @override
  void initState() {
    if (widget.userId != "") {
      _userDetailsFuture = UserAuthMethods().getUserIdentityDetails(
        userId: widget.userId,
      );
      _userDetailsFuture.then((user) {
        setState(() {
          _user = user;
          log(_user!.age.toString());
          log(_user!.sexe.toString());
          log(_user!.groupeSanguinId.toString());
          log(_user!.age.toString());
          _nom = _user!.nom;
          _prenom = _user!.prenom;
          _sexe = _user!.sexe;
          _poids = _user!.poids;
          _age = _user!.age;
          _groupeSanguinId = _user!.groupeSanguinId;

          getBloodType(id: _user!.groupeSanguinId);
          _nomContactUrgence = _user!.nomContactUrgence;
          _telephoneContactUrgence = _user!.telephoneContactUrgence;
          _relation = _user!.relation;
        });
      });
    }
    super.initState();
  }

  getBloodType({required id}) async {
    if (id != "") {
      id = await UserAuthMethods().getInfo(bloodTypeId: id);
      setState(() {
        _groupeSanguin = id;
      });
    }
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
  // FOR MEDICAL'S USER
  // PERMET D'APPELER LE CONTACT CHOISIS, SI PAS DE CONTACT CA N'APPELLE PAS
  void _callSelectedContact() async {
    // Vérifier si la permission d'accéder aux contacts a été accordée
    print(_telephoneContactUrgence);
    if (_telephoneContactUrgence != "") {
      final Uri url = Uri.parse('tel:$_telephoneContactUrgence');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        print('Impossible de lancer l\'appel $url');
      }
    } else {
      print('Aucun contact sélectionné.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          buildSexeFormField(_sexe),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPoidsFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAgeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildGroupeSanguinFormField(),

          SizedBox(height: SizeConfig.screenHeight * 0.03),

          // CONTACT EN CAS D'URGENCE
          RobotoFont(
            title: 'Contact en cas d\'urgence',
            size: getProportionateScreenWidth(22),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          // FOR MEDICAL'S USERS
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Call.svg",
              color: kPrimaryColor,
            ),
            onPressed: () => _callSelectedContact(),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
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

  TextFormField buildGroupeSanguinFormField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = _groupeSanguin!,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Groupe Sanguin",
        hintText: "Champs non rempli",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = _nom,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Nom",
        hintText: "Champs non rempli",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildSexeFormField(String? sexe) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = sexe!,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Sexe",
        hintText: "Champs non rempli",
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
      controller: TextEditingController()..text = _poids!,
      keyboardType: TextInputType.number,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Poids",
        hintText: "Champs non rempli",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildAgeFormField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = "$_age",
      keyboardType: TextInputType.number,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Age",
        hintText: "Champs non rempli",
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
      controller: TextEditingController()..text = _nomContactUrgence!,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Nom",
        hintText: "Champs non rempli",
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
      controller: TextEditingController()..text = _telephoneContactUrgence!,
      keyboardType: TextInputType.phone,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Contact",
        hintText: "Champs non rempli",
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
      controller: TextEditingController()..text = _relation!,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Relation",
        hintText: "Champs non rempli",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    String prenomText = _prenom.join(' ');
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = prenomText,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Prénoms",
        hintText: "Champs non rempli",
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
  //       hintText: "Champs non rempliemail",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
  //     ),
  //   );
  // }
}
