
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CityNavigation extends StatelessWidget {
  final String navigationName;
  final Function? navigationFunction;
  const CityNavigation(
      {super.key, required this.navigationName, this.navigationFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('object');
        navigationFunction!();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingHorizontal),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppTheme.textColor,
                  borderRadius: BorderRadius.circular(25)),
              child: FaIcon(
                FontAwesomeIcons.arrowRight,
                size: 18,
                color: AppTheme.background,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: AppLargeText(
                text: navigationName,

              ),
            )
          ],
        ),
      ),
    );
  }
}
