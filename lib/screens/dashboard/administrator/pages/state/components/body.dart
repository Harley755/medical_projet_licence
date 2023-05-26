import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/screens/dashboard/administrator/pages/state/components/statistique_widget.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class AdminBodyState extends StatelessWidget {
  const AdminBodyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20.0),
        vertical: getProportionateScreenHeight(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RobotoFont(
            title: "Nombre d'utilisateurs",
            size: getProportionateScreenHeight(22.0),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: getProportionateScreenHeight(20.0)),
          const StatistiqueWidget(
            title: 'Total',
            body: '150.00',
          ),
          SizedBox(height: getProportionateScreenHeight(20.0)),
          const StatistiqueWidget(
            title: 'Connecté',
            body: '150',
          ),
          SizedBox(height: getProportionateScreenHeight(20.0)),
          RobotoFont(
            title: "Demande",
            size: getProportionateScreenHeight(22.0),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: getProportionateScreenHeight(20.0)),
          StatistiqueWidget(
            title: 'Création de compte',
            body: '150',
            onPress: () {},
          ),
        ],
      ),
    );
  }
}
