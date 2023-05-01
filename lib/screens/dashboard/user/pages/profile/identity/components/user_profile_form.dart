import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_profile_identity.dart';
import 'package:medical_projet/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProfileFormReadOnly extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const UserProfileFormReadOnly({super.key, required this.formKey});

  @override
  State<UserProfileFormReadOnly> createState() =>
      _UserProfileFormReadOnlyState();
}

class _UserProfileFormReadOnlyState extends State<UserProfileFormReadOnly> {
  late final TextEditingController _emergenceNameController;
  late final TextEditingController _emergenceContactController;

  Contact? _selectedContact;

  @override
  void initState() {
    _emergenceNameController = TextEditingController();
    _emergenceContactController = TextEditingController();
    super.initState();
  }

// SELECTIONNER UN CONTACT DANS LE REPERTOIRE
  void _selectContact() async {
    // Vérifier si la permission d'accéder aux contacts a été accordée
    final PermissionStatus permissionStatus =
        await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      // Permission accordée
      try {
        _selectedContact = await ContactsService.openDeviceContactPicker();
        setState(() {
          _emergenceNameController.text = _selectedContact!.displayName!;
          _emergenceContactController.text =
              (_selectedContact!.phones!.isNotEmpty
                  ? _selectedContact!.phones!.first.value
                  : '')!;
        });
      } on FormOperationException catch (e) {
        if (e.errorCode == FormOperationErrorCode.FORM_OPERATION_CANCELED) {
          // L'utilisateur a annulé l'opération de sélection de contact.
          // Renvoyer l'utilisateur à la page précédente de l'application.

          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const UserProfileIdentity(),
            ),
            (Route<dynamic> route) => false,
          );
          return;
        }
        // Gérer d'autres erreurs de formulaire ici si nécessaire.
      }
    } else {
      // Permission refusée
      print('Permission refusée');
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

  @override
  void dispose() {
    // Nettoyer les contrôleurs de texte lorsqu'ils ne sont plus nécessaires
    _emergenceNameController.dispose();
    _emergenceContactController.dispose();
    super.dispose();
  }

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? sexe;
  String? poids;
  String? emergenceName;
  String? emergenceContact;
  String? emergenceRelationship;
  String? conformPassword;
  bool remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genderItems = [
      'Masculin',
      'Féminin',
    ];

    String? selectedValue;
    return Form(
      key: widget.formKey,
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
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
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
          SizedBox(height: getProportionateScreenHeight(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.contacts_outlined,
                  color: kPrimaryColor,
                ),
                onPressed: () => _selectContact(),
              ),
              // FOR MEDICAL'S USERS
              // IconButton(
              //   icon: SvgPicture.asset(
              //     "assets/icons/Call.svg",
              //     color: kPrimaryColor,
              //   ),
              //   onPressed: () => _callSelectedContact(),
              // ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildEmergenceNameField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmergenceContactField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmergenceRelationshipField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
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
      validator: (value) {
        if (value == null) {
          addError(error: kSexeNullError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value == null) {
          removeError(error: kSexeNullError);
        }
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
      keyboardType: TextInputType.text,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLastNameNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kLastNameNullError);
          return "";
        }
        return null;
      },
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
      keyboardType: TextInputType.number,
      onSaved: (newValue) => poids = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPoidsNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPoidsNullError);
          return "";
        }
        return null;
      },
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
      controller: _emergenceNameController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => emergenceName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmergenceNameNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmergenceNameNullError);
          return "";
        }
        return null;
      },
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
      controller: _emergenceContactController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => emergenceContact = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmergenceContactNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmergenceContactNullError);
          return "";
        }
        return null;
      },
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
      keyboardType: TextInputType.text,
      onSaved: (newValue) => emergenceRelationship = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmergenceRelationshipNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmergenceRelationshipNullError);
          return "";
        }
        return null;
      },
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
      keyboardType: TextInputType.text,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNameNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kFirstNameNullError);
          return "";
        }
        return null;
      },
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Entrer votre adresse email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
