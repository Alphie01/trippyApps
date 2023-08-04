import 'package:TrippyAlpapp/core/classes/shopping/businessOwner.dart';
import 'package:TrippyAlpapp/functions/color.dart';
import 'package:TrippyAlpapp/globals/comments.dart';
import 'package:flutter/material.dart';

class ShoppingProduct {
  final String productName;
  final String productDesc;
  final ShopOwner productOwner;
  final ProductCategory productCategory;
  final List<ProductSizer> productSizer;
  final Comments? comments;
  final List<ProductBatches> productBatches;
  final List<NetworkImage> productImgs;
  final bool isAvailable;

  ShoppingProduct(
      {required this.productName,
      this.productDesc = '',
      required this.productOwner,
      required this.isAvailable,
      required this.productCategory,
      required this.productSizer,
      this.comments,
      required this.productImgs,
      this.productBatches = const []});
}

class ProductSizer {
  final String sizeName;
  final double sizePrice;

  final bool sizeIsAvailable;
  final List<ProductColor> productColor;

  ProductSizer(
      {required this.sizeName,
      required this.sizePrice,
      required this.productColor,
      required this.sizeIsAvailable});
}

class ProductColor {
  final String colorName;
  final HexColor? colorCode;
  final List<NetworkImage>? colorImgs;
  final int stock;
  final bool isTrend;

  ProductColor(
      {required this.colorName,
      this.colorCode,
      this.stock = 0,
      required this.isTrend,
      this.colorImgs});
}

class ProductBatches {}

class ProductCategory {}
