import 'package:trippy_desk_app/constants/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color? color;
  final TextAlign align;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final int maxLineCount;
  AppLargeText(
      {Key? key,
      this.size = 30,
      this.maxLineCount = 2,
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.normal,
      required this.text,
      this.align = TextAlign.start,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        maxLines: maxLineCount,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            decoration: TextDecoration.none,
            color: color ?? AppTheme.textColor,
            fontSize: size,
            fontStyle: fontStyle,
            fontWeight: fontWeight,
          ),
        ));
  }
}
