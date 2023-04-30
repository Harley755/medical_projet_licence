import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/components/body.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/body.dart';
import 'package:medical_projet/size_config.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = "/auth_screen";
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // NESTEDSCROLLVIEW définit une vue de défilement qui contient un header et un body.
        body: NestedScrollView(
          // HEADER RETURN UNE LISTE DE WIDGET DE TYPE SLIVER
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                // l'AppBar flotte lors du défilement vers le haut,
                floating: false,
                // pinned est définie sur true pour que l'AppBar soit épinglée en haut lorsque le défilement atteint le haut de la vue.
                pinned: true,
                // snap est également définie sur true pour que l'AppBar se fixe rapidement en place lorsqu'elle est épinglée.
                snap: false,
                title: PoppinsFont(
                  title: "Créer un compte",
                  size: getProportionateScreenWidth(32),
                  fontWeight: FontWeight.bold,
                ),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                bottom: TabBar(
                  dividerColor: const Color.fromARGB(255, 255, 0, 0),
                  indicatorWeight: 5.0,
                  indicatorColor: kPrimaryColor,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RobotoFont(
                            title: "Informatif",
                            size: getProportionateScreenWidth(16),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RobotoFont(
                            title: "Médical",
                            size: getProportionateScreenWidth(16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          // BODY
          body: const TabBarView(
            children: [
              BodyInfoSignUp(),
              BodyMedicalSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
