import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: paddingHorizontal, bottom: paddingHorizontal / 2),
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: paddingHorizontal / 2, bottom: paddingHorizontal),
          child: AppText(
            text: 'Şarj Asistanım',
            size: 20,
            color: AppBlackTheme.textColor,
          ),
        ),
      ],
    );
  }
}
