import 'package:flutter/material.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/ressources/auth/user_methods.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_otp_verification/components/otp_verification.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/functions.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _phoneNumberController;
  bool _isLoading = false;

  final TextEditingController _countryCode = TextEditingController();

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    _countryCode.text = "+229";

    super.initState();
  }

  void code() async {
    String response = await UserMethods().sendOtpCode(
      phoneNumber: _countryCode.text + _phoneNumberController.text,
      context: context,
    );
    if (response != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    } else {
      showSnackBar(
        "${_countryCode.text + _phoneNumberController.text}",
        context,
      );
      print("Reussi code envoyé");
    }
  }

  void addPhone() async {
    setState(() {
      _isLoading = true;
    });
    String response = await UserMethods().addPhoneNumber(
      phoneNumber: _phoneNumberController.text,
    );
    if (response != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    } else {}
    setState(() {
      _isLoading = false;
    });
  }

  String? phoneNumber;
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneNumberContactField(),
          // buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          _isLoading
              ? const CircularProgressIndicator(color: kPrimaryColor)
              : DefaultButton(
                  text: "Continuer",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addPhone();
                      code();
                    }
                  },
                ),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumberContactField() {
    return TextFormField(
      controller: _phoneNumberController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Numéro",
        hintText: "Entrer le numéro de téléphone",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Call.svg"),
      ),
    );
  }
}
