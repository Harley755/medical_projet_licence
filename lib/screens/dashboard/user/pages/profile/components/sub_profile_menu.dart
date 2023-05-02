import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_projet/constants.dart';

class SubProfileMenu extends StatelessWidget {
  final String text, icon;
  final Function()? press;
  final double? width;
  final double downPadding;

  const SubProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
    this.width,
    this.downPadding = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.symmetric(
      //   horizontal: 20,
      //   vertical: 2,
      // ),
      padding: EdgeInsets.only(
        top: 6,
        bottom: downPadding,
        left: 33,
        right: 33,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: width ?? 22,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: kSecondaryColor),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: kSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}