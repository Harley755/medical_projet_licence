import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/state/components/body.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/profile/components/admin_profile_pic.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/profile/components/body.dart';
import 'package:medical_projet/size_config.dart';

class AdminStatePage extends StatefulWidget {
  const AdminStatePage({super.key});

  @override
  State<AdminStatePage> createState() => _AdminStatePageState();
}

class _AdminStatePageState extends State<AdminStatePage> {
  late String _profileImageUrl;

  User? currentUser = FirebaseAuth.instance.currentUser;
  late Future<model.User> _userDetailsFuture;
  model.User? _user;

  String _nom = "";
  List<String> _prenom = [];
  String _email = "";
  String _photoUrl = "";

  @override
  void initState() {
    _profileImageUrl =
        "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg";

    // GET NAME AND EMAIL
    if (currentUser != null) {
      _userDetailsFuture = UserAuthMethods().getUserIdentityDetails(
        userId: currentUser!.uid,
      );
      _userDetailsFuture.then((user) {
        setState(() {
          _user = user;
          print(_user!.age);
          _nom = _user!.nom;
          _prenom = _user!.prenom;
          _email = _user!.email;
          _photoUrl = _user!.photoUrl!;
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Statistiques",
            style: TextStyle(color: kSecondaryColor),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage(
                    _photoUrl != ""
                        ? _photoUrl
                        : "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg",
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const AdminProfilePic(),
                accountName: RobotoFont(
                  title:
                      '${_prenom.isNotEmpty ? _prenom[0] + (_prenom.length >= 2 ? " ${_prenom[1]}" : "") : ""} $_nom',
                  size: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                accountEmail: RobotoFont(
                  title: _email,
                  size: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
              ),
              const DrawerBody(),
            ],
          ),
        ),
        body: const AdminBodyState(),
      ),
    );
  }
}
