import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsFont extends StatelessWidget {
  final String title;
  final double size;
  final Color? color;
  final FontWeight? fontWeight;
  const PoppinsFont({
    super.key,
    required this.title,
    required this.size,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        fontSize: size.toDouble(),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}

class RobotoFont extends StatelessWidget {
  final String title;
  final double size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const RobotoFont({
    super.key,
    required this.title,
    required this.size,
    this.color,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: size.toDouble(),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
