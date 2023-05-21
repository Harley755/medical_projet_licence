import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/custom_suffix_icon.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/components/form_error.dart';
import 'package:medical_projet/main.dart';
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/user_send_verification_email.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/fileInput/file_input_controller.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/detail_page.dart';
import 'package:medical_projet/services/notification/notification_service.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/functions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _fileMedicalInputController = FileInputController();
  final _fileIdentiteInputController = FileInputController();

  late final TextEditingController _lastNameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _emailController;
  String fileIdentiteInputName = "";
  String fileIdentiteInputPath = "";
  late final TextEditingController _specialiteController;
  String fileMedicalInputName = "";
  String fileMedicalInputPath = "";
  late final TextEditingController _passwordController;

  bool _isLoading = false;

  String token = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _lastNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _emailController = TextEditingController();
    _specialiteController = TextEditingController();
    _passwordController = TextEditingController();

    initializeToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification!.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
      if (message.notification != null) {
        showLocalNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: message.data['senderId'],
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Gérez les notifications lorsque l'utilisateur clique sur la notification
      // Naviguez vers l'écran d'affichage des informations de l'expéditeur
      String senderId = message.data['senderId'];
      navigateToSenderProfileScreen(senderId);
    });

    super.initState();
  }

  // Méthode pour afficher une notification locale
  void showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) {
    // Utilisez flutter_local_notifications pour afficher une notification locale
    // avec le titre et le corps spécifiés
    // Le payload peut être utilisé pour transmettre l'ID de l'expéditeur
    // afin de l'utiliser pour afficher les informations de l'expéditeur sur l'écran correspondant
  }

  // Méthode pour naviguer vers l'écran d'affichage des informations de l'expéditeur
  void navigateToSenderProfileScreen(String senderId) {
    log(senderId);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DetailPage(
        userId: senderId,
      ),
    ));
  }

  initializeToken() async {
    String newToken = await NotificationServices().getToken();
    setState(() {
      token = newToken;
    });
    log("TOKEN $token");
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String response = await UserAuthMethods().signUpProfessional(
      token: token,
      nom: _lastNameController.text.trim(),
      prenom: _firstNameController.text.trim(),
      email: _emailController.text.trim(),
      pieceIdentiteName: fileIdentiteInputName,
      pieceIdentitePath: fileIdentiteInputPath,
      password: _passwordController.text.trim(),
      specialite: _specialiteController.text.trim(),
      carteMedicaleName: fileMedicalInputName,
      carteMedicalePath: fileMedicalInputPath,
    );
    if (response != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar("Compte Médical créé !", context);

      // UserAuthMethods().logOut();
      // ignore: use_build_context_synchronously
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const UserSendEmailVerification(),
      //   ),
      //   (Route<dynamic> route) => false,
      // );
      NotificationServices().sendNotificationToUser(
        token: token,
        title: "Demande de création de compte",
        body:
            "${_firstNameController.text} ${_lastNameController.text} demande a créé un compte",
      );
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
  String? password;
  String? speciality;
  String? conformPassword;
  bool remember = false;
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
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _specialiteController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildInputIdentiteField(_fileIdentiteInputController),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSpecialityFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildInputMedicalField(_fileMedicalInputController),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          // buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(22)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: RobotoFont(
                  size: getProportionateScreenHeight(17),
                  title: "Mot de passe oublié ?",
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(28)),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : DefaultButton(
                  text: "S'inscrire",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      signUpUser();
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Mot de passe",
        hintText: "Veuillez entrer votre mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
