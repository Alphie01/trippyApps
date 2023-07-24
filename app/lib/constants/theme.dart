import 'package:app/functions/color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static Color nearlyWhite = Color(0xFFFAFAFA);
  static Color white = Color(0xFFFFFFFF);
  //light Theme
  static Color textColor = HexColor('#121712');
  static Color background = HexColor('#DCE0E5');
  //dark theme
  static Color background1 = HexColor('#EFF1F3');

  static Color firstColor = HexColor('#805FF8');
  static Color contrastColor1 = HexColor('#896BF9');
  static Color contrastColor2 = HexColor('#9276F9');
  static Color contrastColor3 = HexColor('#AA94FB');
  static Color contrastColor4 = HexColor('#C1B1FC');

  static Color nearlydarkPurple = HexColor('#270722');
  static Color crimson = HexColor('#911F31');
  static Color darkPurple = HexColor('#1D0F1A');
  static Color allowedGreen = HexColor('#2ecc71').withOpacity(.3);
  static List<Color> alertRed = [HexColor('#FC5050'), background];
  static List<Color> alertYellow = [HexColor('#F6D958'), textColor];
  static List<Color> alertGreen = [HexColor('#28AFB0'), textColor];

  static void setDarkTheme() {
    textColor = AppBlackTheme.textColor;
    background = AppBlackTheme.background;
  }

  static void setBrightTheme() {
    textColor = HexColor('#121712');
    background = HexColor('#DCE0E5');
  }
}

class AppBlackTheme {
  AppBlackTheme._();
  static Color nearlyWhite = Color(0xFFFAFAFA);
  static Color white = Color(0xFFFFFFFF);
  //light Theme
  static Color textColor = HexColor('#DCE0E5');
  static Color background = HexColor('#14141D');
  //dark theme
  static Color background1 = HexColor('#EFF1F3');

  static Color firstColor = HexColor('#805FF8');
  static Color contrastColor1 = HexColor('#896BF9');
  static Color contrastColor2 = HexColor('#9276F9');
  static Color contrastColor3 = HexColor('#AA94FB');
  static Color contrastColor4 = HexColor('#C1B1FC');

  static Color nearlydarkPurple = HexColor('#270722');
  static Color crimson = HexColor('#911F31');
  static Color darkPurple = HexColor('#1D0F1A');
  static Color allowedGreen = HexColor('#2ecc71').withOpacity(.3);
  static List<Color> alertRed = [HexColor('#FC5050'), background];
  static List<Color> alertYellow = [HexColor('#F6D958'), textColor];
  static List<Color> alertGreen = [HexColor('#28AFB0'), textColor];
}

Duration defaultDuration = Duration(milliseconds: 400);
