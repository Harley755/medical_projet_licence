import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_projet/utils/constants.dart';

class ProfileMenu extends StatelessWidget {
  final String text, icon;
  final Function()? press;
  final double? width;
  final bool clickToogle;
  final double bottomPadding;

  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
    this.width,
    this.clickToogle = false,
    this.bottomPadding = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.symmetric(
      //   horizontal: 20,
      //   vertical: verticalPadding,
      // ),
      padding: EdgeInsets.only(
        top: 14,
        bottom: clickToogle ? bottomPadding : 14,
        left: 26,
        right: 26,
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
            clickToogle
                ? const Icon(
                    Icons.arrow_drop_down,
                    color: kSecondaryColor,
                  )
                : const Icon(
                    Icons.arrow_forward_ios,
                    color: kSecondaryColor,
                  ),
          ],
        ),
      ),
    );
  }
}
