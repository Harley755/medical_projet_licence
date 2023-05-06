import 'package:flutter/material.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';

class AdminSearchPage extends StatefulWidget {
  const AdminSearchPage({super.key});

  @override
  State<AdminSearchPage> createState() => _AdminSearchPageState();
}

class _AdminSearchPageState extends State<AdminSearchPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: getProportionateScreenHeight(10),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(15),
                horizontal: getProportionateScreenHeight(30),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: kPrimaryColor,
              ),
              labelText: 'Rechercher un compte',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
            onChanged: (String _) {},
          ),
        ),
      ),
    );
  }
}
