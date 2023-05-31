import 'package:flutter/material.dart';
import 'package:medical_projet/components/default_button.dart';
import 'package:medical_projet/size_config.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Function() onPressAccept;
  final Function() onPressRefuse;
  const BottomNavigationBarWidget({
    super.key,
    required this.onPressAccept,
    required this.onPressRefuse,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 60,
              color: Colors.black.withOpacity(.4),
              offset: const Offset(0, 25),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DefaultButton(
                text: "Accepter",
                press: widget.onPressAccept,
              ),
            ),
            Expanded(
              child: DefaultButton(
                text: "Refuser",
                color: Colors.red,
                width: SizeConfig.screenWidth * .49,
                press: widget.onPressRefuse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
