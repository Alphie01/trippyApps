import 'package:TrippyAlpapp/constants/sampleData/shopping/products.dart';
import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/shopping/product.dart';
import 'package:TrippyAlpapp/core/classes/shopping/userLastProducts.dart';
import 'package:TrippyAlpapp/screens/shopping/productPage/productPage.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductCardview extends StatefulWidget {
  const ProductCardview(
      {super.key, required this.index, required this.shoppingProduct});
  final int index;
  final ShoppingProduct shoppingProduct;
  @override
  State<ProductCardview> createState() => _ProductCardviewState();
}

class _ProductCardviewState extends State<ProductCardview> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UserLastProducts.addNewLastSeen(widget.shoppingProduct);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (ctx) {
            return ProductPage(
              shoppingProduct: widget.shoppingProduct,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.background.withOpacity(1),
          boxShadow: [
            BoxShadow(
              color: AppTheme.firstColor.withOpacity(.8),
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                0.0,
                5.0, // Move to bottom 5 Vertically
              ), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.shoppingProduct.productImgs.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                      image: DecorationImage(
                          image: widget.shoppingProduct.productImgs[index],
                          fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: AppText(
                              text: widget.shoppingProduct.productName,
                              maxLineCount: 1,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                AppText(text: '7'),
                                FaIcon(
                                  FontAwesomeIcons.star,
                                  color: AppTheme.textColor,
                                  size: 14,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: AppText(
                      text:
                          '${widget.shoppingProduct.productSizer[0].sizePrice} ₺',
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: paddingHorizontal),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 35,
          crossAxisSpacing: 20,
          childAspectRatio: .6,
          crossAxisCount: 2,
        ),
        itemCount: sampleProducts.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: paddingZero,
        itemBuilder: (BuildContext context, int index) {
          return ProductCardview(
            index: index,
            shoppingProduct: sampleProducts[index],
          );
        },
      ),
    );
  }
}
