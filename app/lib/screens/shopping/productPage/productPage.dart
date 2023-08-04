import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/shopping/product.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.shoppingProduct,
  });

  final ShoppingProduct shoppingProduct;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Stack(
        children: [
          ListView(
            controller: _scrollController,
            padding: paddingZero,
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                height: MediaQuery.of(context).size.height * .66,
                child: PageView.builder(
                  itemCount: widget.shoppingProduct.productImgs.length,
                  itemBuilder: (ctx, index) {
                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.background,
                            image: DecorationImage(
                                image:
                                    widget.shoppingProduct.productImgs[index],
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(25),
                            ),
                          ),
                        ),
                        Positioned(
                          left: paddingHorizontal,
                          child: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            color: AppTheme.textColor,
                            size: 36,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: getPaddingSreenTopHeight()),
            color: AppTheme.background,
            child: Container(
              width: double.maxFinite,
              height: 55,
              padding: EdgeInsets.symmetric(
                  horizontal: paddingHorizontal, vertical: 15),
              color: AppTheme.background,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            size: 36,
                            color: AppTheme.textColor,
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingHorizontal),
                            child: AppText(
                              text: '${widget.shoppingProduct.productName}',
                              maxLineCount: 1,
                              size: 22,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: FaIcon(FontAwesomeIcons.heart),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
