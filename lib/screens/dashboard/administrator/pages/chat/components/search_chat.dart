import 'package:flutter/material.dart';
import 'package:medical_projet/utils/constants.dart';
import 'package:medical_projet/size_config.dart';

class AdminSeachChat extends StatefulWidget {
  const AdminSeachChat({super.key});

  @override
  State<AdminSeachChat> createState() => _AdminSeachChatState();
}

class _AdminSeachChatState extends State<AdminSeachChat> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
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
          labelText: 'Rechercher une discussion',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        onChanged: (String _) {},
      ),
    );
  }
}
