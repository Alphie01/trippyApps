import 'package:TrippyAlpapp/core/classes/categories.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/stringConstans.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/box_view.dart';
import 'package:TrippyAlpapp/widgets/networkImage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Places extends StatefulWidget {
  const Places({
    super.key,
  });

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  int initailPage = 0;
  @override
  Widget build(BuildContext context) {
    return Box_View(
      boxInside: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: paddingHorizontal),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.earth,
                  size: 16,
                  color: AppTheme.textColor,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: paddingHorizontal * .5),
                      child: AppLargeText(text: 'Keşfetmeye Hazır Mısın?')),
                ),
              ],
            ),
          ),
          Container(
            //TODO add desc of container
            padding: EdgeInsets.only(bottom: paddingHorizontal),
            child: AppText(
              text: lorem,
              maxLineCount: 99,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: paddingHorizontal),
            alignment: Alignment.center,
            height: 25,
            child: ListView.builder(
              itemCount: PlaceCategories.allPlaceCategories.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: paddingZero,
              itemBuilder: (BuildContext context, int index) {
                PlaceCategories indexedCategory =
                    PlaceCategories.allPlaceCategories[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      initailPage = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: paddingHorizontal),
                    child: AppLargeText(
                      text: '${indexedCategory.categoryName}',
                      color: initailPage == index
                          ? AppTheme.textColor
                          : AppTheme.textColor.withOpacity(.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .9,
              crossAxisCount: 2,
              crossAxisSpacing: paddingHorizontal,
              mainAxisSpacing: paddingHorizontal,
            ),
            itemCount: 6,
            padding: paddingZero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return NetworkContainer(
                imageUrl: NetworkImage(
                  'https://images.pexels.com/photos/20147082/pexels-photo-20147082/free-photo-of-kar-isik-parlak-acik.jpeg',
                ),
                onLoad: () {},
                child: Container(
                  padding: EdgeInsets.all(paddingHorizontal),
                  decoration:
                      BoxDecoration(color: AppTheme.background.withOpacity(.6)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: 'İşletme İsmi',
                        fontWeight: FontWeight.bold,
                      ),
                      AppText(
                        text: '${PlaceCategories.allPlaceCategories[initailPage].categoryName}',
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.only(top: paddingHorizontal),
            child: Box_View(
              color: AppTheme.contrastColor1.withOpacity(.3),
              horizontal: 0,
              vertical: 0,
              boxInside: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppText(
                    text: 'Daha Fazlası',
                    fontWeight: FontWeight.bold,
                    size: 14,
                  ),
                  FaIcon(
                    FontAwesomeIcons.angleRight,
                    color: AppTheme.textColor,
                    size: 14,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
