import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/shopping/businessOwner.dart';
import 'package:TrippyAlpapp/functions/color.dart';
import 'package:TrippyAlpapp/globals/comments.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class ProductBatches {
  final int batchId;
  final String batchString;
  final int batchPriorty;
  final Widget batchWidget;

  ProductBatches(
      {required this.batchId,
      required this.batchWidget,
      required this.batchPriorty,
      required this.batchString});

  static final List<ProductBatches> _productBatchs = [
    ProductBatches(
      batchId: 1,
      batchPriorty: 5,
      batchString: 'Trend',
      batchWidget: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: AppTheme.contrastColor1,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            AppText(text: 'Trend\nÜrün '),
            FaIcon(FontAwesomeIcons.star),
          ],
        ),
      ),
    ),
    ProductBatches(
      batchId: 2,
      batchPriorty: 5,
      batchString: 'Hızlı Teslimat',
      batchWidget: Row(
        children: [
          AppText(text: 'Hızlı\nTeslimat'),
          FaIcon(FontAwesomeIcons.box),
        ],
      ),
    ),
  ];

  static ProductBatches returnSelectedProductBatchs(int id) {
    ProductBatches? selectedBatch;

    

    return selectedBatch!;
  }
}

class ProductCategory {}
