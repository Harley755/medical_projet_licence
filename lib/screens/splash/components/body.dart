import 'dart:developer';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentIndex = 0;
  changePage(int index) async {
    currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            PageView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              onPageChanged: (index) {
                log(index.toString());
                changePage(index);
              },
              controller: PageController(
                initialPage: 0,
                keepPage: false,
                viewportFraction: 1,
              ),
              pageSnapping: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/welcome-bro.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/welcome-bro.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/welcome-bro.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        bottom: 90.0,
                        child: DefaultButton(
                          text: 'Suivant',
                          press: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  child: DotsIndicator(
                    position: currentIndex.toDouble(),
                    dotsCount: 3,
                    reversed: false,
                    mainAxisAlignment: MainAxisAlignment.center,
                    decorator: DotsDecorator(
                      size: const Size.square(9),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
