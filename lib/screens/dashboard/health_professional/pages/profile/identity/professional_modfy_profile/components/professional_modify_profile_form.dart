import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/ressources/cloud/user_cloud_methods.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_send_verification_email.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/fileInput/file_input_controller.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/functions.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfessionalModifyProfileForm extends StatefulWidget {
  const ProfessionalModifyProfileForm({super.key});

  @override
  State<ProfessionalModifyProfileForm> createState() =>
      _ProfessionalModifyProfileFormState();
}

class _ProfessionalModifyProfileFormState
    extends State<ProfessionalModifyProfileForm> {
  final _fileMedicalInputController = FileInputController();
  final _fileIdentiteInputController = FileInputController();

  late final TextEditingController _lastNameController;
  late final TextEditingController _firstNameController;
  String fileIdentiteInputName = "";
  String fileIdentiteInputPath = "";
  late final TextEditingController _specialiteController;
  String fileMedicalInputName = "";
  String fileMedicalInputPath = "";

  bool _isLoading = false;

  @override
  void initState() {
    _lastNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _specialiteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  void updateProfessionalIdentity() async {
    setState(() {
      _isLoading = true;
    });
    String response = await UserCloudMethods().updateProfessionalIdentity(
      nom: _lastNameController.text.trim(),
      prenom: _firstNameController.text.trim(),
      pieceIdentiteName: fileIdentiteInputName,
      pieceIdentitePath: fileIdentiteInputPath,
      specialite: _specialiteController.text.trim(),
      carteMedicaleName: fileMedicalInputName,
      carteMedicalePath: fileMedicalInputPath,
    );
    if (response != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar("Informations mises à jour !", context);
      // UserAuthMethods().logOut();
      // ignore: use_build_context_synchronously
    }
    setState(() {
      _isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? email;
  String? _errorText;
  String? speciality;
  final List<String?> errors = [];

  void _clearError() {
    setState(() {
      _errorText = null;
    });
  }

  void _setError(String errorText) {
    setState(() {
      _errorText = errorText;
    });
  }

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.02),

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
          // buildConformPassFormField(),
          FormError(errors: errors),

          SizedBox(height: SizeConfig.screenHeight * 0.06),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                )
              : DefaultButton(
                  text: "Mettre à jour",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      updateProfessionalIdentity();
                      // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                    }
                  },
                ),
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
      press: () async {
        _clearError();
        final permissionStatus = await Permission.storage.request();
        if (permissionStatus == PermissionStatus.granted) {
          // SE LIMITER AU FICHIER D'EXTENSIONS JPG, PDF
          final file = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'pdf'],
          );
          if (file != null) {
            _fileMedicalInputController.text = file.files.single.name;
            setState(() {
              fileMedicalInputName = file.files.single.name;
              fileMedicalInputPath = file.files.single.path!;
            });
          } else {
            _setError('Aucun fichier sélectionné');
          }
        } else {
          _setError('Permissions refusées');
        }
      },
    );
  }

  FileInputField buildInputIdentiteField(
    FileInputController fileIdentiteInputController,
  ) {
    return FileInputField(
      labelText: 'Piece d\'identité',
      controller: fileIdentiteInputController,
      press: () async {
        _clearError();
        final permissionStatus = await Permission.storage.request();
        if (permissionStatus == PermissionStatus.granted) {
          // SE LIMITER AU FICHIER D'EXTENSIONS JPG, PDF
          final file = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'pdf'],
          );
          if (file != null) {
            _fileIdentiteInputController.text = file.files.single.name;
            setState(() {
              fileIdentiteInputName = file.files.single.name;
              fileIdentiteInputPath = file.files.single.path!;
            });
          } else {
            _setError('Aucun fichier sélectionné');
          }
        } else {
          _setError('Permissions refusées');
        }
      },
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: _lastNameController,
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
        suffixIcon: CustomSuffixIcon(icon: Icons.person_outlined),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: _firstNameController,
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
        suffixIcon: CustomSuffixIcon(icon: Icons.person_outlined),
      ),
    );
  }

  TextFormField buildSpecialityFormField() {
    return TextFormField(
      controller: _specialiteController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => speciality = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kSpecialityNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kSpecialityNullError);
          return "";
        }
        return null;
      },
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
}
