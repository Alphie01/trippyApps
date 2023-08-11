import 'package:TrippyAlpapp/functions/color.dart';
import 'package:flutter/material.dart';

class MapPlaceCategories {
  final String categoryName;
  final Color categoryColor;
  final String categoryDesc;
  final IconData? categoryIcon;
  final Object? subType;
  final MapPlaceType? placeType;
  MapPlaceCategories(
      {required this.categoryColor,
      required this.categoryDesc,
      required this.categoryName,
      this.placeType,
      this.subType,
      this.categoryIcon});

  static List<MapPlaceCategories> _placeCategories = [
    MapPlaceCategories(
        categoryColor: HexColor('#000'),
        categoryDesc: 'categoryDesc',
        categoryName: 'Bar')
  ];

  static MapPlaceCategories? returnCategory(String categoryName) {
    return _placeCategories.where((object) => object.categoryName == categoryName).first;
  }
}

class MapPlaceType {
  final String placeTypeName;
  final int typeId;
  MapPlaceType({required this.placeTypeName, required this.typeId});
}
