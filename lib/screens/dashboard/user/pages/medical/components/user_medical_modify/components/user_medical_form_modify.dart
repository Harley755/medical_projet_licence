import 'package:flutter/material.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/ressources/cloud/antecedent_methods.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:medical_projet/utils/functions.dart';

class UserMedicalModifyForm extends StatefulWidget {
  const UserMedicalModifyForm({super.key});

  @override
  State<UserMedicalModifyForm> createState() => _UserMedicalModifyFormState();
}

class _UserMedicalModifyFormState extends State<UserMedicalModifyForm> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Antécédents médicaux
  var _familyMedicalHistoryCondition = false;
  var _chronicIllnessesContition = false;
  var _historySevereAllergicReactionsCondition = false;
  var _historyOfTraumaCondition = false;
  var _historyOfRecentSurgeryCondition = false;
  var _historyOfInfectiousDiseasesCondition = false;

  // Médicaments
  var _listOfCurrentMedicationsCondition = false;
  // var _timingScheduleCurrentMedicationsCondition = false;

  // Antécédents médicaux
  String? bloodType;
  String? familyMedicalHistory;
  String? chronicIllnesses;
  String? historySevereAllergicReactions;
  String? historyOfTrauma;
  String? historyOfRecentSurgery;
  String? historyOfInfectiousDiseases;

  // Médicaments
  String? listOfCurrentMedications;
  String? dosageScheduleCurrentMedications;

  // Allergies
  String? knownFoodAllergies;
  String? knownSevereAllergic;

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

  late final TextEditingController _familyMedicalHistoryController;
  late final TextEditingController _chronicIllnessesController;
  late final TextEditingController _historySevereAllergicReactionController;
  late final TextEditingController _historyOfTraumaController;
  late final TextEditingController _historyOfRecentSurgeryController;
  late final TextEditingController _historyOfInfectiousDiseasesController;

  @override
  void initState() {
    _familyMedicalHistoryController = TextEditingController();
    _chronicIllnessesController = TextEditingController();
    _historySevereAllergicReactionController = TextEditingController();
    _historyOfTraumaController = TextEditingController();
    _historyOfRecentSurgeryController = TextEditingController();
    _historyOfInfectiousDiseasesController = TextEditingController();
    super.initState();
  }

  bool _isLoading = false;
  void updateMedicalInformations() async {
    setState(() {
      _isLoading = true;
    });
    String response = await AntecedentMethods().updateMedicalHistory(
      antecedentMedicaux: _familyMedicalHistoryController.text,
      maladiesChronique: _chronicIllnessesController.text,
      antecedentTraumatique: _historyOfTraumaController.text,
      antecedentAllergique: _historySevereAllergicReactionController.text,
      antecedentChirurgie: _historyOfRecentSurgeryController.text,
      antecedentMaladieInfecteuse: _historyOfInfectiousDiseasesController.text,
    );
    if (response != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar("Informations médicales mise à jour avec succès", context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _familyMedicalHistoryController.dispose();
    _chronicIllnessesController.dispose();
    _historySevereAllergicReactionController.dispose();
    _historyOfTraumaController.dispose();
    _historyOfRecentSurgeryController.dispose();
    _historyOfInfectiousDiseasesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValue;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ANTECEDENTS MEDICAUX
          RobotoFont(
            title: 'Antécédents Médicaux',
            size: getProportionateScreenWidth(22),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),

          SizedBox(height: SizeConfig.screenHeight * 0.03),

          // CONDITION FOR FAMILY MEDICAL HISTORY
          buildFamilyMedicalHistoryContition(),

          _familyMedicalHistoryCondition
              ? SizedBox(height: getProportionateScreenHeight(15))
              : const SizedBox(
                  height: 0.0,
                ),

          // FAMILY MEDICAL HISTORY FIELD
          _familyMedicalHistoryCondition
              ? buildFamilyMedicalHistoryField()
              : Container(),

          _familyMedicalHistoryCondition
              ? SizedBox(height: getProportionateScreenHeight(16))
              : const SizedBox(
                  height: 0.0,
                ),

          // CONDITION FOR CHRONIC ILLNESSES
          buildChronicIllnessesContition(),

          _chronicIllnessesContition
              ? SizedBox(height: getProportionateScreenHeight(3))
              : const SizedBox(
                  height: 0.0,
                ),

          // CHRONIC ILLNESSES FIELD
          _chronicIllnessesContition
              ? buildChronicIllnessesField()
              : Container(),

          _chronicIllnessesContition
              ? SizedBox(height: getProportionateScreenHeight(18))
              : const SizedBox(
                  height: 0.0,
                ),

          buildHistorySevereAllergicReactionsCondition(),

          _historySevereAllergicReactionsCondition
              ? SizedBox(height: getProportionateScreenHeight(15))
              : const SizedBox(
                  height: 0.0,
                ),
          _historySevereAllergicReactionsCondition
              ? buildHistorySevereAllergicReactionsField()
              : Container(),

          _historySevereAllergicReactionsCondition
              ? SizedBox(height: getProportionateScreenHeight(18))
              : SizedBox(
                  height: getProportionateScreenHeight(15),
                ),

          buildHistoryOfTraumaCondition(),

          _historyOfTraumaCondition
              ? SizedBox(height: getProportionateScreenHeight(15))
              : const SizedBox(
                  height: 0.0,
                ),
          _historyOfTraumaCondition ? buildHistoryOfTraumaField() : Container(),

          _historyOfTraumaCondition
              ? SizedBox(height: getProportionateScreenHeight(18))
              : SizedBox(
                  height: getProportionateScreenHeight(18),
                ),

          buildHistoryOfRecentSurgeryCondition(),

          _historyOfRecentSurgeryCondition
              ? SizedBox(height: getProportionateScreenHeight(15))
              : const SizedBox(
                  height: 0.0,
                ),
          _historyOfRecentSurgeryCondition
              ? buildHistoryOfRecentSurgeryField()
              : Container(),

          _historyOfRecentSurgeryCondition
              ? SizedBox(height: getProportionateScreenHeight(18))
              : SizedBox(
                  height: getProportionateScreenHeight(18),
                ),

          buildHistoryOfInfectiousDiseasesCondition(),

          _historyOfInfectiousDiseasesCondition
              ? SizedBox(height: getProportionateScreenHeight(15))
              : const SizedBox(
                  height: 0.0,
                ),
          _historyOfInfectiousDiseasesCondition
              ? buildHistoryOfInfectiousDiseasesField()
              : Container(),

          _historyOfInfectiousDiseasesCondition
              ? SizedBox(height: getProportionateScreenHeight(18))
              : SizedBox(
                  height: getProportionateScreenHeight(18),
                ),

          // SizedBox(height: SizeConfig.screenHeight * 0.03),

          // CONTACT EN CAS D'URGENCE
          // RobotoFont(
          //   title: 'Médicaments',
          //   size: getProportionateScreenWidth(22),
          //   textAlign: TextAlign.center,
          //   fontWeight: FontWeight.w600,
          //   color: Colors.black,
          // ),

          // SizedBox(height: SizeConfig.screenHeight * 0.03),

          // buildListOfCurrentMedicationsCondition(),

          // _listOfCurrentMedicationsCondition
          //     ? SizedBox(height: getProportionateScreenHeight(15))
          //     : const SizedBox(
          //         height: 0.0,
          //       ),
          // _listOfCurrentMedicationsCondition
          //     ? buildListOfCurrentMedicationsField()
          //     : Container(),

          // _listOfCurrentMedicationsCondition
          //     ? SizedBox(height: getProportionateScreenHeight(18))
          //     : SizedBox(
          //         height: getProportionateScreenHeight(18),
          //       ),

          FormError(errors: errors),

          SizedBox(height: SizeConfig.screenHeight * 0.1),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor))
              : DefaultButton(
                  text: "Mettre à jour",
                  press: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      updateMedicalInformations();
                    }
                  },
                ),
        ],
      ),
    );
  }

  DropdownButtonFormField2<String> buildBloodTypeFormField(
      List<String> bloodTypeItems, String? selectedValue) {
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
          addError(error: kBloodTypeNullError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value == null) {
          removeError(error: kBloodTypeNullError);
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

  Widget buildFamilyMedicalHistoryContition() {
    return SwitchListTile(
      activeColor: kPrimaryColor,
      activeTrackColor: kSecondaryColor,
      title: RobotoFont(
        title: _familyMedicalHistoryCondition == true
            ? "Antécédents médicaux familiaux : oui"
            : "Antécédents médicaux familiaux : non",
        size: getProportionateScreenWidth(17.0),
      ),
      dense: true,
      value: _familyMedicalHistoryCondition,
      onChanged: (value) {
        setState(() {
          _familyMedicalHistoryCondition = value;
        });
      },
    );
  }

  TextFormField buildFamilyMedicalHistoryField() {
    return TextFormField(
      controller: _familyMedicalHistoryController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => familyMedicalHistory = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFamilyMedicalHistoryNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && _familyMedicalHistoryCondition) {
          addError(error: kFamilyMedicalHistoryNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Antécédents médicaux familiaux",
        hintText: "Entrer vos antécédents",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Widget buildChronicIllnessesContition() {
    return SwitchListTile(
      activeColor: kPrimaryColor,
      activeTrackColor: kSecondaryColor,
      title: RobotoFont(
        title: _chronicIllnessesContition == true
            ? "Maladies chroniques : oui"
            : "Maladies chroniques : non",
        size: getProportionateScreenWidth(17.0),
      ),
      dense: true,
      value: _chronicIllnessesContition,
      onChanged: (value) {
        setState(() {
          _chronicIllnessesContition = value;
        });
      },
    );
  }

  TextFormField buildChronicIllnessesField() {
    return TextFormField(
      controller: _chronicIllnessesController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => chronicIllnesses = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kChronicIllnessesNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && _chronicIllnessesContition) {
          addError(error: kChronicIllnessesNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Maladies chroniques",
        hintText: "Entrer vos maladies chroniques",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Widget buildHistorySevereAllergicReactionsCondition() {
    return SwitchListTile(
      activeColor: kPrimaryColor,
      activeTrackColor: kSecondaryColor,
      title: RobotoFont(
        title: _historySevereAllergicReactionsCondition == true
            ? "Antécédents de réactions allergiques graves : oui"
            : "Antécédents de réactions allergiques graves : non",
        size: getProportionateScreenWidth(17.0),
      ),
      dense: true,
      value: _historySevereAllergicReactionsCondition,
      onChanged: (value) {
        setState(() {
          _historySevereAllergicReactionsCondition = value;
        });
      },
    );
  }

  TextFormField buildHistorySevereAllergicReactionsField() {
    return TextFormField(
      controller: _historySevereAllergicReactionController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => historySevereAllergicReactions = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kHistorySevereAllergicReactionsNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && _chronicIllnessesContition) {
          addError(error: kHistorySevereAllergicReactionsNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Antécédents de réactions allergiques graves",
        hintText: "Entrer vos antécédents",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Widget buildHistoryOfTraumaCondition() {
    return SwitchListTile(
      activeColor: kPrimaryColor,
      activeTrackColor: kSecondaryColor,
      title: RobotoFont(
        title: _historyOfTraumaCondition == true
            ? "Antécédents de traumatismes : oui"
            : "Antécédents de traumatismes : non",
        size: getProportionateScreenWidth(17.0),
      ),
      dense: true,
      value: _historyOfTraumaCondition,
      onChanged: (value) {
        setState(() {
          _historyOfTraumaCondition = value;
        });
      },
    );
  }

  TextFormField buildHistoryOfTraumaField() {
    return TextFormField(
      controller: _historyOfTraumaController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => historyOfTrauma = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kHistoryOfTraumaNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && _historyOfTraumaCondition) {
          addError(error: kHistoryOfTraumaNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Antécédents de traumatismes",
        hintText: "Entrer vos antécédents",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Widget buildHistoryOfRecentSurgeryCondition() {
    return SwitchListTile(
      activeColor: kPrimaryColor,
      activeTrackColor: kSecondaryColor,
      title: RobotoFont(
        title: _historyOfRecentSurgeryCondition == true
            ? "Antécédents de chirurgie récente : oui"
            : "Antécédents de chirurgie récente : non",
        size: getProportionateScreenWidth(17.0),
      ),
      dense: true,
      value: _historyOfRecentSurgeryCondition,
      onChanged: (value) {
        setState(() {
          _historyOfRecentSurgeryCondition = value;
        });
      },
    );
  }

  TextFormField buildHistoryOfRecentSurgeryField() {
    return TextFormField(
      controller: _historyOfRecentSurgeryController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => historyOfRecentSurgery = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kHistoryOfRecentSurgeryNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && _historyOfRecentSurgeryCondition) {
          addError(error: kHistoryOfRecentSurgeryNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Antécédents de chirurgie récente",
        hintText: "Entrer vos antécédents",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Widget buildHistoryOfInfectiousDiseasesCondition() {
    return SwitchListTile(
      activeColor: kPrimaryColor,
      activeTrackColor: kSecondaryColor,
      title: RobotoFont(
        title: _historyOfInfectiousDiseasesCondition == true
            ? "Antécédents de maladies infectieuses : oui"
            : "Antécédents de maladies infectieuses : non",
        size: getProportionateScreenWidth(17.0),
      ),
      dense: true,
      value: _historyOfInfectiousDiseasesCondition,
      onChanged: (value) {
        setState(() {
          _historyOfInfectiousDiseasesCondition = value;
        });
      },
    );
  }

  TextFormField buildHistoryOfInfectiousDiseasesField() {
    return TextFormField(
      controller: _historyOfInfectiousDiseasesController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => historyOfInfectiousDiseases = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kHistoryOfInfectiousDiseasesNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && _historyOfInfectiousDiseasesCondition) {
          addError(error: kHistoryOfInfectiousDiseasesNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Antécédents de maladies infectieuses",
        hintText: "Entrer vos antécédents",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Widget buildListOfCurrentMedicationsCondition() {
    return SwitchListTile(
      activeColor: kPrimaryColor,
      activeTrackColor: kSecondaryColor,
      title: RobotoFont(
        title: _listOfCurrentMedicationsCondition == true
            ? "Médicaments en cours ? : oui"
            : "Médicaments en cours ? : non",
        size: getProportionateScreenWidth(17.0),
      ),
      dense: true,
      value: _listOfCurrentMedicationsCondition,
      onChanged: (value) {
        setState(() {
          _listOfCurrentMedicationsCondition = value;
        });
      },
    );
  }

  TextFormField buildListOfCurrentMedicationsField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => listOfCurrentMedications = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kListOfCurrentMedicationsNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && _listOfCurrentMedicationsCondition) {
          addError(error: kListOfCurrentMedicationsNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Liste des médicaments en cours",
        hintText: "Entrer la liste des médicaments",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildDosageCurrentMedicationsField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => listOfCurrentMedications = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kListOfCurrentMedicationsNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty && _listOfCurrentMedicationsCondition) {
          addError(error: kListOfCurrentMedicationsNullError);
          print("clicked");
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Liste des médicaments en cours",
        hintText: "Entrer la liste des médicaments",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
