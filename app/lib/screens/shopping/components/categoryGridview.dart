import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/shopping/shopping_category_model.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryGridview extends StatelessWidget {
  const CategoryGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: paddingHorizontal),
      child: GridView.builder(
        padding: paddingZero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
        ),
        itemCount: ShoppingCategory.returnShoppingCategories().length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(ShoppingCategory.returnShoppingCategories()[index]
                    .categoryIcon, size: 32, color: AppTheme.firstColor,),
                Container(
                  margin: EdgeInsets.symmetric(vertical: paddingHorizontal),
                  child: AppText(
                      text: ShoppingCategory.returnShoppingCategories()[index]
                          .categoryName),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
