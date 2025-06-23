import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/screens/search/search_screen.dart';
import 'package:TrippyAlpapp/widgets/ads/adsOfApp.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/notification__logs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    super.key,
    required this.headerColor,
    required this.headerIconColor,
    required this.scaffoldKey,
    required this.updatePage,
    required this.blurOpacity,
    this.customWidgetUpdate,
    this.isCustom = false,
    this.customWidget,
  });

  final Color headerColor;
  final Color headerIconColor;
  final double blurOpacity;
  final Function updatePage;
  final Function? customWidgetUpdate;
  final bool isCustom;
  final Widget? customWidget;

  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
          top: getPaddingScreenTopHeight(),
          left: paddingHorizontal,
          right: paddingHorizontal),
      decoration: BoxDecoration(
        color: headerColor,
        borderRadius: BorderRadius.circular(paddingHorizontal),
        boxShadow: [
          BoxShadow(
            color: AppTheme.contrastColor1.withOpacity(blurOpacity),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        height: AppBar().preferredSize.height,
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.bars,
                    color: headerIconColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: paddingHorizontal),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: AppBar().preferredSize.height -
                            1.75 * paddingHorizontal,
                        width: AppBar().preferredSize.height -
                            1.75 * paddingHorizontal,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: headerIconColor == Colors.white
                                ? AppTheme.logo
                                : AssetImage('assets/logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: paddingHorizontal / 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: 'Şehir',
                              size: 13,
                              color: headerIconColor,
                              fontWeight: FontWeight.bold,
                            ),
                            AppText(
                              text: 'Kılavuzu',
                              size: 13,
                              color: headerIconColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: FaIcon(
                      FontAwesomeIcons.solidComment,
                      color: headerIconColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
