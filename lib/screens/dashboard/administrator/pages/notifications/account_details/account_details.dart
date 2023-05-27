import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/notifications/account_details/components/bottom_navigation_bar_widget.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/notifications/account_details/components/header_widget.dart';
import 'package:medical_projet/size_config.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountDetailsState();
  }
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(10.0),
                                ),
                                child: Container(
                                  height: 120.0,
                                  width: 120.0,
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 5, color: Colors.white),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey.shade300,
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
                    title: "John DOE",
                    size: getProportionateScreenWidth(22.0),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: getProportionateScreenHeight(14.0)),
                  PoppinsFont(
                    title: "johndoe@gmail.com",
                    size: getProportionateScreenWidth(17.0),
                  ),
                  SizedBox(height: getProportionateScreenHeight(14.0)),
                  PoppinsFont(
                    title: "Cardiologue",
                    size: getProportionateScreenWidth(17.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
