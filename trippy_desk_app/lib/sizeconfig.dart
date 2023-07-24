import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getPaddingSreenTopHeight() {
  return AppBar().preferredSize.height;
}

double getPaddingSreenBottomHeight() {
  MediaQueryData mediaQueryData = SizeConfig._mediaQueryData;
  return mediaQueryData.padding.bottom;
}
