import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/models/admin_model.dart' as model;
import 'package:medical_projet/ressources/cloud/statut_methods.dart';
import 'package:medical_projet/services/mail/mail.dart';
import 'package:medical_projet/utils/functions.dart';
import 'package:photo_view/photo_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/models/professional_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/notifications/account_details/components/bottom_navigation_bar_widget.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/notifications/account_details/components/header_widget.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class AccountDetails extends StatefulWidget {
  final String userId;
  const AccountDetails({super.key, required this.userId});

  @override
  State<StatefulWidget> createState() {
    return _AccountDetailsState();
  }
}

class _AccountDetailsState extends State<AccountDetails> {
  final _formKey = GlobalKey<FormState>();
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<model.Professional> _userDetailsFuture;
  model.Professional? _professional;

  late Future<model.Admin> _userAdminDetailsFuture;
  model.Admin? _admin;

  late final TextEditingController _motifController;

  String _nom = "";
  List<String> _prenom = [];
  String _email = "";
  String _specialite = "";
  String _photoUrl = "";
  String _photoCarteMedicale = "";
  String _photoPieceIdentite = "";

  String _emailAdmin = "";

  bool _isAccept = false;
  bool _isRefuse = false;

  isAccepted() {
    setState(() {
      _isAccept = !_isAccept;
    });
    if (_isRefuse) {
      setState(() {
        _isRefuse = false;
      });
    }
  }

  isRefused() {
    setState(() {
      _isRefuse = !_isRefuse;
    });
    if (_isAccept) {
      setState(() {
        _isAccept = false;
      });
    }
  }

  bool _isLoading = false;

  void stateAccount(
      {required String etatStatut, required String message}) async {
    setState(() {
      _isLoading = true;
    });
    String response = await StatutMethods().updateEtatAndStatut(
        docEmail: _email, etatStatut: etatStatut, motif: _motifController.text);
    if (response != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(message, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    if (currentUser != null) {
      _userDetailsFuture = UserAuthMethods().getProfessionalIdentityDetails(
        userId: widget.userId,
      );
      _userDetailsFuture.then((professional) {
        setState(() {
          _professional = professional;
          print(_professional!.nom);
          _nom = _professional!.nom;
          _prenom = _professional!.prenom;
          _specialite = _professional!.specialite;
          _email = _professional!.email;
          _photoUrl = _professional!.photoUrl;
          // _telephone = _professional!.specialite;
          _photoCarteMedicale = _professional!.photoCarteMedicale;
          _photoPieceIdentite = _professional!.photoPieceIdentite;
        });
      });

      _userAdminDetailsFuture = UserAuthMethods().getAdminIdentityDetails(
        userId: currentUser!.uid,
      );
      _userAdminDetailsFuture.then((admin) {
        setState(() {
          _admin = admin;

          _emailAdmin = _admin!.email;
        });
      });
    }
    _motifController = TextEditingController();

    // ADMIN-EMAIL

    super.initState();
  }

  @override
  void dispose() {
    _motifController.dispose();
    super.dispose();
  }

  void sendMail({required String texte}) async {
    String response = await MailService().sendEmailToUser(
      userEmail: _email,
      adminEmail: _emailAdmin,
      text: "$texte ${_motifController.text}",
      password: dotenv.env['EMAIL_PASSWORD']!,
    );
    if (response == 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar("Mail envoyé avec succes", context);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(response, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 150,
                  child: HeaderWidget(
                    showIcon: false,
                    height: 150,
                    icon: Icons.person_add_alt_1_rounded,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                height: 120.0,
                                width: 120.0,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    width: 5,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _photoUrl == ""
                                          ? "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg"
                                          : _photoUrl,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20.0),
              ),
              child: Column(
                children: [
                  PoppinsFont(
                    title:
                        '${_prenom.isNotEmpty ? _prenom[0] + (_prenom.length >= 2 ? " ${_prenom[1]}" : "") : ""} $_nom',
                    size: getProportionateScreenWidth(22.0),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: getProportionateScreenHeight(14.0)),
                  PoppinsFont(
                    title: _email,
                    size: getProportionateScreenWidth(17.0),
                  ),
                  SizedBox(height: getProportionateScreenHeight(14.0)),
                  PoppinsFont(
                    title: _specialite,
                    size: getProportionateScreenWidth(17.0),
                  ),
                  SizedBox(height: getProportionateScreenHeight(14.0)),
                  buildProfessionalPhoto(_photoCarteMedicale),
                  SizedBox(height: getProportionateScreenHeight(14.0)),
                  buildProfessionalPhoto(_photoPieceIdentite),
                  SizedBox(height: getProportionateScreenHeight(24.0)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Visibility(
                          visible: _isAccept,
                          child: Column(
                            children: [
                              buildAcceptFormField(
                                controller: _motifController,
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(14.0),
                              ),
                              DefaultButton(
                                text: "Enrégistrer",
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // if all are valid then go to success screen
                                    stateAccount(
                                      etatStatut: 'accepter',
                                      message: "Compte accepté avec succès",
                                    );
                                    sendMail(
                                      texte:
                                          'Votre compte a été validé. En effet ',
                                    );
                                    // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                                  }
                                },
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(22.0),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _isRefuse,
                          child: Column(
                            children: [
                              buildRefuseFormField(
                                controller: _motifController,
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(14.0),
                              ),
                              DefaultButton(
                                text: "Enrégistrer",
                                color: Colors.red,
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // if all are valid then go to success screen
                                    stateAccount(
                                      etatStatut: 'refuser',
                                      message: "Compte refusé avec succès",
                                    );
                                    sendMail(
                                      texte:
                                          'Sommes en regret de vous annoncez que votre demande de validation de compte a été refusé. En effet ',
                                    );
                                    // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                                  }
                                },
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(22.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        onPressAccept: isAccepted,
        onPressRefuse: isRefused,
      ),
    );
  }

  Widget buildProfessionalPhoto(String photoCarteMedicale) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 280.0,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          image: DecorationImage(
            image: NetworkImage(photoCarteMedicale),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}

TextFormField buildAcceptFormField({
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    maxLines: null,
    keyboardType: TextInputType.multiline,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Champs obligatoire";
      }
      return null;
    },
    decoration: const InputDecoration(
      labelText: "Motif d'acceptation",
      hintText: "Motif",
      // If  you are using latest version of flutter then lable text and hint text shown like this
      // if you r using flutter less then 1.20.* then maybe this is not working properly
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}

TextFormField buildRefuseFormField({
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    maxLines: null,
    keyboardType: TextInputType.multiline,
    onChanged: (value) {},
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Champs obligatoire";
      }
      return null;
    },
    decoration: const InputDecoration(
      labelText: "Motif de refus",
      hintText: "Motif",
      // If  you are using latest version of flutter then lable text and hint text shown like this
      // if you r using flutter less then 1.20.* then maybe this is not working properly
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
  );
}
