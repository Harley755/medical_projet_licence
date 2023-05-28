import 'dart:developer';
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
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<model.Professional> _userDetailsFuture;
  model.Professional? _professional;

  String _nom = "";
  String _prenom = "";
  String _email = "";
  String _specialite = "";
  String _photoUrl = "";
  String _photoCarteMedicale = "";
  String _photoPieceIdentite = "";

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
    }
    super.initState();
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
                    title: "$_prenom $_nom",
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
                  SizedBox(height: getProportionateScreenHeight(14.0)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
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
