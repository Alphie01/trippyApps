import 'package:flutter/material.dart';

class CityDesc {
  final String descTitle;
  final String? descSubtitle;
  final String descText;

  CityDesc(
      {required this.descTitle, this.descSubtitle, required this.descText});
}

class CityFamous {
  final String famousName;
  final String famousDesc;
  final List<NetworkImage>? famousImage;

  CityFamous(
      {required this.famousName, this.famousImage, required this.famousDesc});
}

class CityScore {
  final String scoreName;
  final String scoresDesc;
  final IconData? scoreIcon;
  final double scoreCount;

  CityScore(
      {required this.scoreName,
      required this.scoresDesc,
      this.scoreIcon,
      required this.scoreCount});

  void scoreWidget() {
    print(scoreName);
  }
}

class CityGuide {
  final String guideName;
  final IconData? guideNameDescriptor;
  final String guideText;
  final IconData? guideTextDescriptor;
  final String guideDesc;

  CityGuide(
      {required this.guideName,
      this.guideNameDescriptor,
      required this.guideText,
      this.guideTextDescriptor,
      required this.guideDesc});
}

class CityProsCons {
  final String prosconsTitle;
  final String? prosconsDesc;
  final bool prosconsIsPros;

  CityProsCons(
      {required this.prosconsTitle,
      this.prosconsDesc,
      required this.prosconsIsPros});
}
