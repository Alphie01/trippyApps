import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/shopping/businessOwner.dart';
import 'package:TrippyAlpapp/core/classes/shopping/product.dart';
import 'package:TrippyAlpapp/functions/color.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<ShoppingProduct> sampleProducts = [
  ShoppingProduct(
    productName: 'Halter Yaka Esnek Çıtçıtlı Örme Body',
    isAvailable: true,
    productCategory: ProductCategory(),
    productOwner: ShopOwner(),
    productImgs: [
      NetworkImage(
          'https://cdn.dsmcdn.com/ty293/product/media/images/20220110/15/24462696/67124790/2/2_org_zoom.jpg'),
      NetworkImage(
          'https://cdn.dsmcdn.com/ty276/product/media/images/20211224/18/16010065/126233164/2/2_org_zoom.jpg'),
      NetworkImage(
          'https://cdn.dsmcdn.com/ty278/product/media/images/20211224/18/16010065/126233164/3/3_org_zoom.jpg'),
      NetworkImage(
          'https://cdn.dsmcdn.com/ty290/product/media/images/20220107/13/23004508/67124785/2/2_org_zoom.jpg'),
      NetworkImage(
          'https://cdn.dsmcdn.com/ty917/product/media/images/20230529/17/370303388/902796996/2/2_org_zoom.jpg'),
      NetworkImage(
          'https://cdn.dsmcdn.com/ty915/product/media/images/20230529/17/370303388/902796996/3/3_org_zoom.jpg'),
    ],
    productSizer: [
      ProductSizer(
        productColor: [
          ProductColor(
            colorName: 'Pembe',
            isTrend: false,
            stock: 21,
            colorCode: HexColor('#9b59b6'),
          ),
          ProductColor(
            colorName: 'Kahve rengi',
            isTrend: false,
            stock: 21,
            colorCode: HexColor('#1abc9c'),
          ),
          ProductColor(
            colorName: 'Mavi',
            isTrend: false,
            stock: 21,
            colorCode: HexColor('#e67e22'),
          ),
          ProductColor(
            colorName: 'Gri',
            isTrend: false,
            stock: 21,
            colorCode: HexColor('#f1c40f'),
          ),
          ProductColor(
            colorName: 'Siyah',
            isTrend: false,
            stock: 21,
            colorCode: HexColor('#000000'),
          ),
          ProductColor(
            colorName: 'Beyaz',
            isTrend: false,
            stock: 21,
            colorCode: HexColor('#ffffff'),
          ),
        ],
        sizeIsAvailable: true,
        sizeName: '',
        sizePrice: 144.99,
      ),
    ],
    productBatches: [
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
    ],
  )
];
