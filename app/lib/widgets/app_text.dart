import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color? color;
  final TextAlign align;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final int? maxLineCount;

  static int getTextCount() {
    return 5;
  }

  static bool hasTextOverflow(String text,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 1}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: text,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                decoration: TextDecoration.none,
                color: AppTheme.textColor,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal),
          )),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  AppText(
      {Key? key,
      this.size = 12,
      this.maxLineCount = 5,
      required this.text,
      this.fontWeight = FontWeight.normal,
      this.fontStyle = FontStyle.normal,
      this.align = TextAlign.start,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLineCount,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
            decoration: TextDecoration.none,
            color: color ?? AppTheme.textColor,
            fontSize: size,
            fontWeight: fontWeight,
            fontStyle: fontStyle),
      ),
    );
  }
}
