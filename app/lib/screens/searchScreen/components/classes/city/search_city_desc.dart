import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/cityGuide/cities.dart';
import 'package:TrippyAlpapp/widgets/app_large_text.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchCityDesc extends StatefulWidget {
  const SearchCityDesc({super.key});

  @override
  State<SearchCityDesc> createState() => _SearchCityDescState();
}

class _SearchCityDescState extends State<SearchCityDesc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
          top: getPaddingSreenTopHeight() + 12,
          left: paddingHorizontal,
          right: paddingHorizontal),
      height: MediaQuery.of(context).size.height,
      child: ListView(
        padding: paddingZero,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: AppTheme.textColor,
              ),
              AppLargeText(
                text: Cities.selectedCites.cityName,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          ListView.builder(
            itemCount: Cities.selectedCites.cityDesc.length,
            padding: paddingZero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: paddingHorizontal),
                    child: AppText(
                      text: Cities.selectedCites.cityDesc[index].descTitle,
                      size: 16,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: paddingHorizontal),
                    child: AppText(
                        text: Cities.selectedCites.cityDesc[index].descText),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
