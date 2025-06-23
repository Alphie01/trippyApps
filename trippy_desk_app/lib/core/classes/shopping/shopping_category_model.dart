import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShoppingCategoryModel {
  final IconData categoryIcon;
  final String categoryName;

  ShoppingCategoryModel(
      {required this.categoryIcon, required this.categoryName});
}

class ShoppingCategory {
  static List<ShoppingCategoryModel> _shoppingCategoryList = [
    ShoppingCategoryModel(categoryIcon: FontAwesomeIcons.shirt, categoryName: 'Gömlek'),
    ShoppingCategoryModel(categoryIcon: FontAwesomeIcons.tshirt, categoryName: 'T-Shirt'),
    ShoppingCategoryModel(categoryIcon: FontAwesomeIcons.phone, categoryName: 'Telefone'),
    ShoppingCategoryModel(categoryIcon: FontAwesomeIcons.computer, categoryName: 'Bilgisayar'),

  ];

  static List<ShoppingCategoryModel> returnShoppingCategories() {
    return _shoppingCategoryList;
  }

}
