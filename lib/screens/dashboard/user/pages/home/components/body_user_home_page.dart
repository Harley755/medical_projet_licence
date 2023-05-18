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
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .75,
                mainAxisSpacing: getProportionateScreenWidth(20.0),
                crossAxisSpacing: getProportionateScreenHeight(20.0),
              ),
              itemBuilder: (context, index) => Container(
                width: 200.0,
                height: 500.0,
                key: ValueKey(index),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: kPrimaryColor,
                ),
                child: Center(
                  child: Text(
                    index.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
