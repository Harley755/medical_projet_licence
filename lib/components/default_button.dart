import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:medical_projet/constants.dart';
import 'package:medical_projet/size_config.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function()? press;
  const DefaultButton({super.key, required this.text, this.press});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
