import 'package:flutter/material.dart';
import 'package:medical_projet/size_config.dart';
import 'package:medical_projet/utils/constants.dart';

class BodyUserHomePage extends StatefulWidget {
  const BodyUserHomePage({Key? key}) : super(key: key);

  @override
  State<BodyUserHomePage> createState() => _BodyUserHomePageState();
}

class _BodyUserHomePageState extends State<BodyUserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: SizeConfig.screenHeight * .1),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20.0),
            ),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    color: kPrimaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
