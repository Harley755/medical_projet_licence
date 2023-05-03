import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminProfilePic extends StatelessWidget {
  const AdminProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: 190,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://i.pinimg.com/736x/08/2a/1b/082a1bb32a158d7270582c044fca7bfd.jpg",
            ),
          ),
          Positioned(
            right: -8,
            bottom: 0,
            child: SizedBox(
              height: 30,
              width: 30,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
