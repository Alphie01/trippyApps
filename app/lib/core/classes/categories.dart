import 'package:flutter/material.dart';

class PlaceCategories {
  final String categoryName, categoryDesc;
  final IconData? categoryIcon;
  final Function? categoryOnclickFunc;
  final List<PlaceCategories>? subCategories;

  PlaceCategories({
    required this.categoryDesc,
    this.subCategories,
    required this.categoryName,
    this.categoryIcon,
    this.categoryOnclickFunc,
  });

  static List<PlaceCategories> allPlaceCategories = [
    PlaceCategories(
      categoryDesc: "",
      categoryName: 'Gece Hayatı',
      subCategories: [
        PlaceCategories(categoryDesc: "", categoryName: 'Bar - Pub'),
        PlaceCategories(categoryDesc: "", categoryName: 'Gece Kulübü'),
      ],
    ),
    PlaceCategories(categoryDesc: "", categoryName: 'Cafe'),
    PlaceCategories(categoryDesc: "", categoryName: 'Restaurant'),
    PlaceCategories(categoryDesc: "", categoryName: 'Pastane'),
    PlaceCategories(categoryDesc: "", categoryName: 'Butik Mağaza'),
    PlaceCategories(categoryDesc: "", categoryName: 'Alışveriş Merkezi'),
    PlaceCategories(categoryDesc: "", categoryName: 'Market'),
    PlaceCategories(
      categoryDesc: "",
      categoryName: 'Sağlık',
      subCategories: [
        PlaceCategories(categoryDesc: "", categoryName: 'Hastane'),
        PlaceCategories(categoryDesc: "", categoryName: 'Klinik'),
        PlaceCategories(categoryDesc: "", categoryName: 'Diyetisyen'),
        PlaceCategories(categoryDesc: "", categoryName: 'Eczane'),
        PlaceCategories(categoryDesc: "", categoryName: 'Diğer'),
      ],
    ),
    PlaceCategories(categoryDesc: "", categoryName: 'Eğlence'),
    PlaceCategories(categoryDesc: "", categoryName: 'İbadethane'),
    PlaceCategories(categoryDesc: "", categoryName: 'Kişisel Bakım'),
  ];
}
