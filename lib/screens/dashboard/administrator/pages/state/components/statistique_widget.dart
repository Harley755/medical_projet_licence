import 'package:flutter/material.dart';
import 'package:medical_projet/components/fonts.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class StatistiqueWidget extends StatelessWidget {
  final String title;
  final String body;
  final Function()? onPress;
  const StatistiqueWidget({
    super.key,
    required this.title,
    required this.body,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RobotoFont(
                    title: title,
                    size: getProportionateScreenWidth(20.0),
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Divider(
                height: 2.0,
                indent: 20.0,
                endIndent: 20.0,
                color: kPrimaryColor,
              ),
              SizedBox(height: getProportionateScreenHeight(7.0)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RobotoFont(
                      title: body,
                      size: getProportionateScreenWidth(30.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
