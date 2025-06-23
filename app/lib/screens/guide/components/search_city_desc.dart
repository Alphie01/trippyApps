
import 'package:TrippyAlpapp/core/classes/cities.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchCityDesc extends StatefulWidget {
  final Function? backToFirst, openOthers, closeModal;

  const SearchCityDesc(
      {super.key, this.backToFirst, this.openOthers, this.closeModal});

  @override
  State<SearchCityDesc> createState() => _SearchCityDescState();
}

class _SearchCityDescState extends State<SearchCityDesc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: AppTheme.background,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * .7,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Cities.selectedCites.cityPhotos[0], fit: BoxFit.cover),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
          ),
          Container(
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * .7,
                ),
                Container(
                  color: AppTheme.background,
                  padding: EdgeInsets.only(
                      left: paddingHorizontal,
                      right: paddingHorizontal,
                      top: paddingHorizontal),
                  child: ListView.builder(
                    itemCount: Cities.selectedCites.cityDesc.length,
                    physics: NeverScrollableScrollPhysics(),
                    padding: paddingZero,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: paddingHorizontal),
                                child: AppText(
                                  text: Cities
                                      .selectedCites.cityDesc[index].descTitle,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: paddingHorizontal),
                                    child: FaIcon(
                                      FontAwesomeIcons.play,
                                      color: AppTheme.firstColor,
                                      size: 15,
                                    ),
                                  ),
                                  Container(
                                    child: AppText(
                                      text: 'Bu Bölümü Dinle',
                                      color: AppTheme.firstColor,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: paddingHorizontal),
                            child: AppText(
                              text:
                                  Cities.selectedCites.cityDesc[index].descText,
                              maxLineCount: 99999,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              top: getPaddingScreenTopHeight(),
              bottom: paddingHorizontal,
            ),
            child: Container(
              height: AppBar().preferredSize.height,
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.closeModal!();
                    },
                    child: Container(
                      padding: EdgeInsets.all(paddingHorizontal),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.background.withOpacity(.6)),
                      child: FaIcon(
                        FontAwesomeIcons.xmark,
                        color: AppTheme.textColor,
                      ),
                    ),
                  ),
                  Container()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
