import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/size_config.dart';

class AdminPictureName extends StatelessWidget {
  const AdminPictureName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          backgroundImage: NetworkImage(
              "https://pfps.gg/assets/pfps/6143-boruto-kawaki.png"),
        ),
        SizedBox(width: getProportionateScreenWidth(17)),
        const Expanded(
          child: RobotoFont(
            title: "John Doe",
            size: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
