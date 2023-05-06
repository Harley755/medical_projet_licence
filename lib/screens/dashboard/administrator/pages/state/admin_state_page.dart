import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Admin State Page",
            style: TextStyle(color: kSecondaryColor),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/08/2a/1b/082a1bb32a158d7270582c044fca7bfd.jpg',
                  ), // URL de votre image
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
                accountName: RobotoFont(
                  title: "John Doe",
                  size: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                accountEmail: RobotoFont(
                  title: "johndoe@gmailcom",
                  size: getProportionateScreenWidth(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                currentAccountPicture: const AdminProfilePic(),
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
