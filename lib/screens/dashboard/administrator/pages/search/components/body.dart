import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/search/components/admin_list_result.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/search/components/admin_users_list.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class BodyAdminSearch extends StatefulWidget {
  const BodyAdminSearch({super.key});

  @override
  State<BodyAdminSearch> createState() => _BodyAdminSearchState();
}

class _BodyAdminSearchState extends State<BodyAdminSearch> {
  final TextEditingController searchNomController = TextEditingController();
  final TextEditingController searchPrenomController = TextEditingController();

  @override
  void dispose() {
    searchNomController.dispose();
    searchPrenomController.dispose();
    super.dispose();
  }

  bool _isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(17.0),
          vertical: getProportionateScreenWidth(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Le reste du contenu ici...
            Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: searchNomController,
                decoration: InputDecoration(
                  prefixIconColor: kPrimaryColor,
                  focusColor: kPrimaryColor,
                  contentPadding: EdgeInsets.symmetric(
                    // horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(16),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "nom",
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (String _) {
                  setState(() {
                    if (_ == "") {
                      _isShowUsers = false;
                    } else {
                      _isShowUsers = true;
                    }
                  });
                },
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(20.0)),
            Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: searchPrenomController,
                decoration: InputDecoration(
                  prefixIconColor: kPrimaryColor,
                  focusColor: kPrimaryColor,
                  contentPadding: EdgeInsets.symmetric(
                    // horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(16),
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "prénom",
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (String _) {
                  setState(() {
                    if (_ == "") {
                      _isShowUsers = false;
                    } else {
                      _isShowUsers = true;
                    }
                  });
                },
              ),
            ),
            // TextFormField(
            //   controller: searchPrenomController,
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.symmetric(
            //       vertical: getProportionateScreenHeight(15),
            //       horizontal: getProportionateScreenHeight(30),
            //     ),
            //     prefixIcon: const Icon(
            //       Icons.search,
            //       color: kPrimaryColor,
            //     ),
            //     labelText: 'Rechercher',
            //     hintText: "prenom",
            //     floatingLabelBehavior: FloatingLabelBehavior.always,
            //   ),
            // ),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            RobotoFont(
              title: "Liste",
              size: 17.0,
              color: Colors.black.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            !_isShowUsers
                ? const AdminUserList()
                : AdminListResult(
                    searchNomController: searchNomController,
                    searchPrenomController: searchPrenomController,
                  )
          ],
        ),
      ),
    );
  }
}
