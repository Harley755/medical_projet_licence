import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical_projet/size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  final String? svgIcon;
  final IconData? icon;
  const CustomSuffixIcon({
    Key? key,
    this.svgIcon,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: svgIcon != null
          ? SvgPicture.asset(
              svgIcon!,
              height: getProportionateScreenWidth(18),
            )
          : Icon(icon),
    );
  }
}
