import 'package:flutter/material.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';

class ProfessionalSearch extends StatefulWidget {
  const ProfessionalSearch({super.key});

  @override
  State<ProfessionalSearch> createState() => _ProfessionalSearchState();
}

class _ProfessionalSearchState extends State<ProfessionalSearch> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: getProportionateScreenHeight(10),
      ),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(15),
            horizontal: getProportionateScreenHeight(30),
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: kPrimaryColor,
          ),
          labelText: 'Rechercher',
          hintText: "Rechercher un utilisateur",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onChanged: (String _) {},
      ),
    );
  }
}