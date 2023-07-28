import 'package:flutter/material.dart';

class SearchCategory {
  final String categoryName;
  final AssetImage categoryAssetImg;
  final Function? categoryOnclickFunc;

  SearchCategory(
      {required this.categoryName,
      required this.categoryAssetImg,
      this.categoryOnclickFunc});
}
