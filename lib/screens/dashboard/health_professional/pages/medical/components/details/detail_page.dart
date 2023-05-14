import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/health_professional/pages/medical/components/details/components/identity_detail_page/identity_detail_page.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/screens/auth/informative_account/sign_up/components/body.dart';
import 'package:medical_projet/screens/auth/medical_account/sign_up/components/body.dart';
import 'package:medical_projet/size_config.dart';

class DetailPage extends StatefulWidget {
  static String routeName = "/professional/details";
  final String userId;
  const DetailPage({
    super.key,
    required this.userId,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
                  title: "Données",
                  size: getProportionateScreenWidth(25),
                  fontWeight: FontWeight.w400,
                ),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                bottom: TabBar(
                  indicatorWeight: 2.5,
                  indicatorColor: kPrimaryColor,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RobotoFont(
                            title: "Identités",
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
                            title: "Medicales",
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
          body: TabBarView(
            children: [
              IdentityDetail(userId: widget.userId),
              const Center(child: Text("Medical")),
              // BodyMedicalSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
