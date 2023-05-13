import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/dashboard/user/pages/medical/components/user_medical_modify/user_medical_modify.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/models/antecedent_model.dart' as model;

class UserMedicalForm extends StatefulWidget {
  const UserMedicalForm({super.key});

  @override
  State<UserMedicalForm> createState() => _UserMedicalFormState();
}

class _UserMedicalFormState extends State<UserMedicalForm> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<model.Antecedent> _userMedicalFuture;
  model.Antecedent? _antecedent;

  String _antecedentMedicaux = "";
  String _maladiesChronique = "";
  String _antecedentTraumatique = "";
  String _antecedentAllergique = "";
  String _antecedentChirurgie = "";
  String _antecedentMaladieInfecteuse = "";

  @override
  void initState() {
    if (currentUser != null) {
      _userMedicalFuture =
          UserAuthMethods().getUserMedicalDetails(userId: currentUser!.uid);
      _userMedicalFuture.then((antecedent) {
        setState(() {
          _antecedent = antecedent;
          print(_antecedent!.antecedentMedicaux);
          _antecedentMedicaux = _antecedent!.antecedentMedicaux;
          _maladiesChronique = _antecedent!.maladiesChronique;
          _antecedentTraumatique = _antecedent!.antecedentTraumatique;
          _antecedentAllergique = _antecedent!.antecedentAllergique;
          _antecedentChirurgie = _antecedent!.antecedentChirurgie;
          _antecedentMaladieInfecteuse =
              _antecedent!.antecedentMaladieInfecteuse;

          _antecedentMedicaux.isNotEmpty
              ? _familyMedicalHistoryCondition = true
              : false;
          _maladiesChronique.isNotEmpty
              ? _chronicIllnessesContition = true
              : false;
          _antecedentTraumatique.isNotEmpty
              ? _historyOfTraumaCondition = true
              : false;
          _antecedentAllergique.isNotEmpty
              ? _historySevereAllergicReactionsCondition = true
              : false;
          _antecedentChirurgie.isNotEmpty
              ? _historyOfRecentSurgeryCondition = true
              : false;
          _antecedentMaladieInfecteuse.isNotEmpty
              ? _historyOfInfectiousDiseasesCondition = true
              : false;
        });
      });
    }
    _familyMedicalHistoryCondition = false;
    _chronicIllnessesContition = false;
    _historySevereAllergicReactionsCondition = false;
    _historyOfTraumaCondition = false;
    _historyOfRecentSurgeryCondition = false;
    _historyOfInfectiousDiseasesCondition = false;
    super.initState();
  }

  // Antécédents médicaux

  late bool _familyMedicalHistoryCondition;
  late bool _chronicIllnessesContition;
  late bool _historySevereAllergicReactionsCondition;
  late bool _historyOfTraumaCondition;
  late bool _historyOfRecentSurgeryCondition;
  late bool _historyOfInfectiousDiseasesCondition;

  // Médicaments
  var _listOfCurrentMedicationsCondition = false;
  // var _timingScheduleCurrentMedicationsCondition = false;

  // Antécédents médicaux
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: FutureBuilder<model.Antecedent>(
            future: _userMedicalFuture,
            builder: (BuildContext context,
                AsyncSnapshot<model.Antecedent> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('Pas de données trouvées');
              } else {
                _antecedent = snapshot.data;
                _antecedentMedicaux = _antecedent!.antecedentMedicaux;
                _maladiesChronique = _antecedent!.maladiesChronique;
                _antecedentAllergique = _antecedent!.antecedentAllergique;
                _antecedentTraumatique = _antecedent!.antecedentTraumatique;
                _antecedentChirurgie = _antecedent!.antecedentChirurgie;
                _antecedentMaladieInfecteuse =
                    _antecedent!.antecedentMaladieInfecteuse;
                _antecedentMedicaux.isNotEmpty
                    ? _familyMedicalHistoryCondition = true
                    : false;
                _maladiesChronique.isNotEmpty
                    ? _chronicIllnessesContition = true
                    : false;
                _antecedentTraumatique.isNotEmpty
                    ? _historyOfTraumaCondition = true
                    : false;
                _antecedentAllergique.isNotEmpty
                    ? _historySevereAllergicReactionsCondition = true
                    : false;
                _antecedentChirurgie.isNotEmpty
                    ? _historyOfRecentSurgeryCondition = true
                    : false;
                _antecedentMaladieInfecteuse.isNotEmpty
                    ? _historyOfInfectiousDiseasesCondition = true
                    : false;
                return Column(
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
                        ? buildFamilyMedicalHistoryField(_antecedentMedicaux)
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
                        ? buildChronicIllnessesField(_maladiesChronique)
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
                        ? buildHistorySevereAllergicReactionsField(
                            _antecedentAllergique,
                          )
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
                    _historyOfTraumaCondition
                        ? buildHistoryOfTraumaConditionField(
                            _antecedentTraumatique,
                          )
                        : Container(),

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
                        ? buildHistoryOfRecentSurgeryField(_antecedentChirurgie)
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
                        ? buildHistoryOfInfectiousDiseasesField(
                            _antecedentMaladieInfecteuse,
                          )
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

                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                  ],
                );
              }
            },
          ),
        ),
        DefaultButton(
          text: "Editer",
          press: () {
            Navigator.pushNamed(
              context,
              UserMedicalModify.routeName,
            );
          },
        ),
      ],
    );
  }

  // DropdownButtonFormField2<String> buildBloodTypeFormField(
  //     List<String> bloodTypeItems, String? selectedValue) {
  //   return DropdownButtonFormField2(
  //     decoration: InputDecoration(
  //       //Add isDense true and zero Padding.
  //       //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
  //       isDense: true,
  //       contentPadding: EdgeInsets.zero,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       //Add more decoration as you want here
  //       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
  //     ),
  //     isExpanded: true,
  //     hint: const Text(
  //       'Selectioner votre groupe sanguin',
  //       style: TextStyle(fontSize: 14),
  //     ),
  //     items: bloodTypeItems
  //         .map((item) => DropdownMenuItem<String>(
  //               value: item,
  //               child: Text(
  //                 item,
  //                 style: const TextStyle(
  //                   fontSize: 14,
  //                 ),
  //               ),
  //             ))
  //         .toList(),
  //     validator: (value) {
  //       if (value == null) {
  //
  //         return "";
  //       }
  //       return null;
  //     },
  //     onChanged: (value) {
  //       if (value == null) {
  //
  //       }
  //     },
  //     onSaved: (value) {
  //       selectedValue = value.toString();
  //     },
  //     buttonStyleData: const ButtonStyleData(
  //       height: 60,
  //       padding: EdgeInsets.only(left: 20, right: 10),
  //     ),
  //     iconStyleData: const IconStyleData(
  //       icon: Icon(
  //         Icons.arrow_drop_down,
  //         color: Colors.black45,
  //       ),
  //       iconSize: 30,
  //     ),
  //     dropdownStyleData: DropdownStyleData(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //     ),
  //   );
  // }

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
      onChanged: (value) {},
    );
  }

  TextFormField buildFamilyMedicalHistoryField(String antecedentMedicaux) {
    return TextFormField(
      readOnly: true,
      maxLines: null,
      controller: TextEditingController()..text = antecedentMedicaux,
      keyboardType: TextInputType.multiline,
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
      onChanged: (value) {},
    );
  }

  TextFormField buildChronicIllnessesField(String maladiesChronique) {
    return TextFormField(
      readOnly: true,
      maxLines: null,
      controller: TextEditingController()..text = maladiesChronique,
      keyboardType: TextInputType.multiline,
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
      onChanged: (value) {},
    );
  }

  TextFormField buildHistorySevereAllergicReactionsField(
    String antecedentAllergique,
  ) {
    return TextFormField(
      readOnly: true,
      maxLines: null,
      controller: TextEditingController()..text = antecedentAllergique,
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => historySevereAllergicReactions = newValue,
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
      onChanged: (value) {},
    );
  }

  TextFormField buildHistoryOfTraumaConditionField(
    String antecedentTraumatique,
  ) {
    return TextFormField(
      readOnly: true,
      maxLines: null,
      controller: TextEditingController()..text = antecedentTraumatique,
      keyboardType: TextInputType.multiline,
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
      onChanged: (value) {},
    );
  }

  TextFormField buildHistoryOfRecentSurgeryField(String antecedentChirurgie) {
    return TextFormField(
      readOnly: true,
      maxLines: null,
      controller: TextEditingController()..text = _antecedentChirurgie,
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => historyOfRecentSurgery = newValue,
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
      onChanged: (value) {},
    );
  }

  TextFormField buildHistoryOfInfectiousDiseasesField(
    String antecedentMaladieInfecteuse,
  ) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController()..text = antecedentMaladieInfecteuse,
      maxLines: null,
      keyboardType: TextInputType.multiline,
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
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => listOfCurrentMedications = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {}
      },
      validator: (value) {
        if (value!.isEmpty && _listOfCurrentMedicationsCondition) {
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
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => listOfCurrentMedications = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {}
      },
      validator: (value) {
        if (value!.isEmpty && _listOfCurrentMedicationsCondition) {
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
