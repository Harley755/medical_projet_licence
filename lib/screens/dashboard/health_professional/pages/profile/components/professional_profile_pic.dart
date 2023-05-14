// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/utils/functions.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfessionalProfilePic extends StatefulWidget {
  const ProfessionalProfilePic({super.key});

  @override
  State<ProfessionalProfilePic> createState() => _ProfessionalProfilePicState();
}

class _ProfessionalProfilePicState extends State<ProfessionalProfilePic> {
  late String _profileImageUrl;

  bool _isLoading = false;

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
      // Ignorer l'erreur si l'image de profil n'existe pas encore.
    });
    super.initState();
  }

  final picker = ImagePicker();

  Future<void> _uploadGalleryImage() async {
    setState(() {
      _isLoading = true;
    });
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final user = FirebaseAuth.instance.currentUser;
    final fileName = user!.uid;

    final storageRef =
        FirebaseStorage.instance.ref().child('avatars/$fileName');
    final uploadTask = storageRef.putFile(File(pickedFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final imageUrl = await snapshot.ref.getDownloadURL();

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(fileName)
        .update({'photoUrl': imageUrl});

    setState(() {
      _profileImageUrl = imageUrl;
      _isLoading = false;
    });

    showSnackBar("Photo de profile bien définie", context);
  }

  Future<void> _uploadCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;

    final user = FirebaseAuth.instance.currentUser;
    final fileName = user!.uid;

    final storageRef =
        FirebaseStorage.instance.ref().child('avatars/$fileName');
    final uploadTask = storageRef.putFile(File(pickedFile.path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final imageUrl = await snapshot.ref.getDownloadURL();

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(fileName)
        .update({'photoUrl': imageUrl});

    setState(() {
      _profileImageUrl = imageUrl;
    });

    showSnackBar("Photo de profile bien définie", context);
  }

  void _selectGallerieImage() async {
    // Vérifier si la permission d'accéder aux fichiers a été accordée
    final PermissionStatus permissionStatus =
        await Permission.storage.request();
    if (permissionStatus.isGranted) {
      // L'utilisateur a accepté l'autorisation, vous pouvez accéder à la galerie
      try {
        _uploadGalleryImage();
      } catch (e) {
        print(e);
      }
    } else if (permissionStatus == PermissionStatus.denied) {
      // L'utilisateur a refusé l'autorisation, vous pouvez afficher un message pour l'inciter à l'accepter dans les paramètres de l'application
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Autorisation refusée'),
          content: const Text(
              'Vous devez autoriser l\'accès à la galerie pour pouvoir choisir une photo.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Paramètres'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      // L'utilisateur a refusé l'autorisation avec une option de non-redemande ultérieure, vous devez l'inciter à l'accepter dans les paramètres de l'application
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Autorisation refusée'),
          content: const Text(
              'Vous devez autoriser l\'accès à la galerie dans les paramètres de l\'application pour pouvoir choisir une photo.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Paramètres'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  void _imageBytakingPhoto() async {
// Vérifier si la permission d'accéder aux fichiers a été accordée
    final PermissionStatus permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      // L'utilisateur a accepté l'autorisation, vous pouvez accéder à la galerie
      try {
        _uploadCameraImage();
      } catch (e) {
        print(e);
      }
    } else if (permissionStatus == PermissionStatus.denied) {
      // L'utilisateur a refusé l'autorisation, vous pouvez afficher un message pour l'inciter à l'accepter dans les paramètres de l'application
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Autorisation refusée'),
          content: const Text(
              'Vous devez autoriser l\'accès à l\'appareil photo pour pouvoir prendre une photo.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Paramètres'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      // L'utilisateur a refusé l'autorisation avec une option de non-redemande ultérieure, vous devez l'inciter à l'accepter dans les paramètres de l'application
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Autorisation refusée'),
          content: const Text(
              'Vous devez autoriser l\'accès à la galerie dans les paramètres de l\'application pour pouvoir choisir une photo.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Paramètres'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  showChangeProfilePictureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: RobotoFont(
            title: 'Changer photo de profile',
            size: getProportionateScreenWidth(20.0),
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
          content: RobotoFont(
            title:
                'Voulez vous en prendre une autre ou en choisir une existante?',
            size: getProportionateScreenWidth(17.0),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: RobotoFont(
                title: 'Appareil Photo',
                size: getProportionateScreenWidth(17.0),
              ),
              onPressed: () {
                // Code to take a new photo goes here
                _imageBytakingPhoto();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: RobotoFont(
                title: 'Gallerie',
                size: getProportionateScreenWidth(17.0),
              ),
              onPressed: () {
                // Code to choose an existing photo goes here
                _selectGallerieImage();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: RobotoFont(
                title: 'Retour',
                size: getProportionateScreenWidth(17.0),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator(color: kPrimaryColor))
        : SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                FutureBuilder<String>(
                  future: Future.value(_profileImageUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data!),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      );
                    }
                  },
                ),
                Positioned(
                  right: -9,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF5F6F9),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                        onPressed: () =>
                            showChangeProfilePictureDialog(context),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
