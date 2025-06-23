import 'package:trippy_desk_app/constants/sharedPreferencesKeynames.dart';
import 'package:trippy_desk_app/constants/sizeConfig.dart';
import 'package:trippy_desk_app/constants/theme.dart';
import 'package:trippy_desk_app/core/sharedPreferences.dart';
import 'package:trippy_desk_app/globals/users.dart';
import 'package:trippy_desk_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Drawers extends StatefulWidget {
  const Drawers({super.key, required this.updatePage, required this.darkTheme});

  final bool darkTheme;
  final Function updatePage;

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  bool switchPos = false;

  @override
  void initState() {
    setState(() {
      switchPos = SharedPref.getBoolValuesSF(darkOrLightMode);
    });

    // TODO: implement initState
    super.initState();
  }

  void changeToDarkTheme(value) async {
    SharedPref.addBoolToSF(darkOrLightMode, value);
    if (value) {
      AppTheme.setDarkTheme();
    } else {
      AppTheme.setBrightTheme();
    }
    Future.delayed(defaultDuration, () {
      widget.updatePage(pageId: 94);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: paddingZero,
      children: [
        Container(
          padding:
              EdgeInsets.only(top: getPaddingSreenTopHeight() + 24, bottom: 24),
          decoration: BoxDecoration(
            color: AppTheme.firstColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      image: User.userProfile.userProfilePhoto,
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      text: User.userProfile.userName!,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    AppText(
                      text: '@${User.userProfile.userKAdi}',
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ListTile(
          title: AppText(
            text: 'Profili Düzenle',
            size: 14,
          ),
          onTap: () {},
        ),
        ListTile(
          title: AppText(
            text: 'Adreslerim',
            size: 14,
          ),
          onTap: () {},
        ),
        ListTile(
          title: AppText(
            text: 'Kaydettiklerim ve Beğendiklerim',
            size: 14,
          ),
          onTap: () {},
        ),
        ListTile(
          title: AppText(
            text: 'Rezervasyonlarım',
            size: 14,
          ),
          onTap: () {},
        ),
        ListTile(
          title: AppText(
            text: 'Siparişlerim',
            size: 14,
          ),
          onTap: () {},
        ),
        ListTile(
          title: AppText(
            text: 'Kuponlarım',
            size: 14,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Karanlık Tema',
                size: 14,
              ),
              Switch(
                // thumb color (round icon)
                activeColor: AppTheme.firstColor,
                activeTrackColor: AppTheme.firstColor.withOpacity(.3),
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                // boolean variable value
                value: switchPos,
                // changes the state of the switch
                onChanged: (value) {
                  setState(() {
                    switchPos = value;
                  });
                  changeToDarkTheme(switchPos);
                },
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.cog,
                size: 14,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: AppText(
                  text: 'Ayarlar ve Gizlilik',
                  size: 14,
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.xmark,
                size: 16,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: AppText(
                  text: 'Çıkış Yap',
                  size: 14,
                ),
              ),
            ],
          ),
          onTap: () {
            SharedPref.removeStrValue(isShownWelcomeInfos);
            SharedPref.removeStrValue(userToken);
            widget.updatePage(pageId: 90);
          },
        ),
      ],
    );
  }
}
