import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/ressources/cloud/user_cloud_methods.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_modfy_profile/user_profile_identity_modify.dart';
import 'package:medical_projet/screens/dashboard/user/pages/profile/identity/user_profile_identity.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:medical_projet/utils/functions.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProfileFormModify extends StatefulWidget {
  const UserProfileFormModify({super.key});

  @override
  State<UserProfileFormModify> createState() => _UserProfileFormModifyState();
}

class _UserProfileFormModifyState extends State<UserProfileFormModify> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController _nomController;
  late final TextEditingController _prenomController;
  String sexeValue = "";
  late final TextEditingController _poidsController;
  String bloodTypeValue = "";
  late final TextEditingController _ageController;
  late final TextEditingController _emergenceNameController;
  late final TextEditingController _emergenceContactController;
  late final TextEditingController _relation;

  late Future<List<Map<String, dynamic>>> _bloodTypeListFuture;

  Contact? _selectedContact;

  @override
  void initState() {
    _bloodTypeListFuture = UserCloudMethods()
        .getAllDocumentsInCollection('blood_type')
        .then((documents) {
      List<Map<String, dynamic>> list = [];
      for (DocumentSnapshot document in documents) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;
        list.add(documentData);
      }
      print(list);
      return list;
    });
    _ageController = TextEditingController();
    _relation = TextEditingController();
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _poidsController = TextEditingController();
    _emergenceNameController = TextEditingController();
    _emergenceContactController = TextEditingController();

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
  void dispose() {
    // Nettoyer les contrôleurs de texte lorsqu'ils ne sont plus nécessaires
    _nomController.dispose();
    _prenomController.dispose();
    _poidsController.dispose();
    _ageController.dispose();
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
  String? age;
  String? bloodType;
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

  // SELECTIONNER UN CONTACT DANS LE REPERTOIRE
  void _selectContact(BuildContext context) async {
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const UserProfileIdentityModify(),
            ),
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

  bool _isLoading = false;
  void updateInformations() async {
    setState(() {
      _isLoading = true;
    });
    String response = await UserCloudMethods().updateUserIdentity(
      nom: _nomController.text,
      prenom: _prenomController.text,
      sexe: sexeValue,
      poids: _poidsController.text,
      age: _ageController.text,
      groupeSanguinId: bloodTypeValue,
      nomContactUrgence: _emergenceNameController.text,
      telephoneContactUrgence: _emergenceContactController.text,
      relation: _relation.text,
    );
    if (response != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar("Information mise à jour avec succès", context);

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(
        context,
        UserProfileIdentity.routeName,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genderItems = [
      'Masculin',
      'Féminin',
    ];

    String? selectedValue;
    return Form(
      key: formKey,
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
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAgeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          FutureBuilder<List<Map<String, dynamic>>>(
            future: _bloodTypeListFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Afficher une indication de chargement si la liste est en cours de récupération
              } else if (snapshot.hasError) {
                return Text('Une erreur est survenue : ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('Aucune donnée trouvée.');
              } else {
                print(snapshot.data);
                // Afficher la liste de dropdowns une fois qu'elle est disponible
                List<Map<String, dynamic>> bloodTypeList = snapshot.data!;
                return buildBloodTypeFormField(
                  bloodTypeList,
                  bloodTypeValue,
                );
              }
            },
          ),

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
                onPressed: () => _selectContact(context),
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
          SizedBox(height: SizeConfig.screenHeight * 0.06),
          !_isLoading
              ? DefaultButton(
                  text: "Mettre à jour",
                  press: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      // if all are valid then go to success screen
                      updateInformations();
                    }
                  },
                )
              : const Center(child: CircularProgressIndicator()),
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
        setState(() {
          sexeValue = value;
        });
        return null;
      },
      onChanged: (value) {
        if (value == null) {
          removeError(error: kSexeNullError);
        }
        sexeValue = value.toString();
      },
      onSaved: (value) {
        sexeValue = value.toString();
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

  DropdownButtonFormField2<Map<String, dynamic>> buildBloodTypeFormField(
      List<Map<String, dynamic>> bloodTypeItems, String? selectedBloodValue) {
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
      items: bloodTypeItems
          .map(
            (item) => DropdownMenuItem<Map<String, dynamic>>(
              key: Key(item["bloodTypeId"]
                  .toString()), // Ajoutez une clé unique à chaque élément
              value: item,
              child: Text(
                item["libelle"],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          addError(error: kBloodTypeNullError);
          return "";
        }
        setState(() {
          bloodTypeValue = value["bloodTypeId"].toString();
          print(bloodTypeValue);
        });
        return null;
      },
      onChanged: (value) {
        if (value == null) {
          removeError(error: kBloodTypeNullError);
        }
        if (value != null) {
          bloodTypeValue = value["bloodTypeId"].toString();
          print(bloodTypeValue);
        }
      },
      onSaved: (value) {
        if (value != null) {
          bloodTypeValue = value["bloodTypeId"].toString();
          print(bloodTypeValue);
        }
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
      controller: _nomController,
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
      controller: _poidsController,
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

  TextFormField buildAgeFormField() {
    return TextFormField(
      controller: _ageController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => age = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAgeNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAgeNullError);
          return "";
        }
        return null;
      },
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
      controller: _relation,
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
      controller: _prenomController,
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

  // TextFormField buildEmailFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.emailAddress,
  //     onSaved: (newValue) => email = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kEmailNullError);
  //       } else if (emailValidatorRegExp.hasMatch(value)) {
  //         removeError(error: kInvalidEmailError);
  //       }
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kEmailNullError);
  //         return "";
  //       } else if (!emailValidatorRegExp.hasMatch(value)) {
  //         addError(error: kInvalidEmailError);
  //         return "";
  //       }
  //       return null;
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
