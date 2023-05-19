import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/models/user_model.dart' as model;
import 'package:medical_projet/ressources/auth/user_auth_methods.dart';
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
  String _prenom = "";
  String _email = "";

  @override
  void initState() {
    _profileImageUrl =
        "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg";
    // Chargement de l'image de profil à partir de Firebase Storage si elle existe.

    final user = FirebaseAuth.instance.currentUser;
    final fileName = user!.uid;
    final storageRef =
        FirebaseStorage.instance.ref().child('avatars/$fileName');
    storageRef.getDownloadURL().then((url) {
      setState(() {
        _profileImageUrl = url;
      });
    }).catchError((error) {
      print(error);
    });

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
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                icon: StreamBuilder<String>(
                    stream: Stream.value(_profileImageUrl),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        print(snapshot.hasError);
                      }
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(snapshot.data!),
                        );
                      } else {
                        return const CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                            "https://64.media.tumblr.com/eb8013a5fded5dcb55eee5ba2e48c86c/012efcaf904bfd8e-89/s640x960/cbb4836ddab081451c45286f7f9ab278f99f59f7.pnj",
                          ),
                        );
                      }
                    }),
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
                  title: '$_prenom $_nom',
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
      ),
    );
  }
}
