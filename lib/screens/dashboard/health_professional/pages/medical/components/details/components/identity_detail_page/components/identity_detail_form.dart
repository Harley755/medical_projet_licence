import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/components/user_profile_form.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

class IdentityDetailFormReadOnly extends StatefulWidget {
  final String userId;
  const IdentityDetailFormReadOnly({
    super.key,
    required this.userId,
  });

  @override
  State<IdentityDetailFormReadOnly> createState() =>
      _IdentityDetailFormReadOnlyState();
}

class _IdentityDetailFormReadOnlyState
    extends State<IdentityDetailFormReadOnly> {
  late Future<model.User> _userDetailsFuture;
  model.User? _user;

  String _nom = "";
  String _prenom = "";
  String? _sexe = "";
  String? _groupeSanguinId = "";
  String? _poids = "";
  String? _age = "";
  String? _nomContactUrgence = "";
  String? _telephoneContactUrgence = "";
  String? _relation = "";

  @override
  void initState() {
    if (widget.userId != null) {
      _userDetailsFuture = UserAuthMethods().getUserIdentityDetails(
        userId: widget.userId,
      );
      _userDetailsFuture.then((user) {
        setState(() {
          _user = user;
          print(_user!.age);
          _nom = _user!.nom;
          _prenom = _user!.prenom;
          _sexe = _user!.sexe;
          _poids = _user!.poids;
          _age = _user!.age;
          _groupeSanguinId = _user!.groupeSanguinId;
          _nomContactUrgence = _user!.nomContactUrgence;
          _telephoneContactUrgence = _user!.telephoneContactUrgence;
          _relation = _user!.relation;
        });
      });
    }
    super.initState();
  }

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
    final List<String> genderItems = [
      'Masculin',
      'Féminin',
    ];

    final List<String> bloodItems = [
      '0+',
      'A-',
    ];

    String? selectedValue;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IDENTITY
          // RobotoFont(
          //   title: 'Identité',
          //   size: getProportionateScreenWidth(22),
          //   textAlign: TextAlign.center,
          //   fontWeight: FontWeight.w600,
          //   color: Colors.black,
          // ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSexeFormField(genderItems, _sexe),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPoidsFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAgeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildGroupeSanguinFormField(bloodItems, selectedValue),

          SizedBox(height: SizeConfig.screenHeight * 0.03),

          // CONTACT EN CAS D'URGENCE
          RobotoFont(
            title: 'Contact en cas d\'urgence',
            size: getProportionateScreenWidth(22),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          // FOR MEDICAL'S USERS
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Call.svg",
              color: kPrimaryColor,
            ),
            onPressed: () => _callSelectedContact(),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
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

  DropdownButtonFormField2<String> buildGroupeSanguinFormField(
      List<String> bloodItems, String? selectedValue) {
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
        'Selectioner votre groupe sanguin',
        style: TextStyle(fontSize: 14),
      ),
      items: bloodItems
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
      // value: selectedValue,
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
      controller: TextEditingController()..text = _nom,
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
      controller: TextEditingController()..text = _poids!,
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

  TextFormField buildAgeFormField() {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()
        ..text = _age != "" ? "$_age ans" : '$_age',
      keyboardType: TextInputType.number,
      onChanged: (value) {},
      decoration: const InputDecoration(
        labelText: "Age",
        hintText: "Entrer votre age",
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
      controller: TextEditingController()..text = _telephoneContactUrgence!,
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
      controller: TextEditingController()..text = _relation!,
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
      controller: TextEditingController()..text = _prenom,
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
