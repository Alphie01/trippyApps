import 'package:TrippyAlpapp/core/classes/user.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/box_view.dart';
import 'package:TrippyAlpapp/widgets/headerWidget.dart';
import 'package:TrippyAlpapp/widgets/networkImage.dart';
import 'package:TrippyAlpapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainSettingsPage extends StatefulWidget {
  const MainSettingsPage(
      {Key? key,
      this.animationController,
      this.updatePage,
      required this.scaffoldKey})
      : super(key: key);

  final AnimationController? animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function? updatePage;

  @override
  _MainSettingsPageState createState() => _MainSettingsPageState();
}

class _MainSettingsPageState extends State<MainSettingsPage>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation, headerAnimation;
  AnimationController? headerAnimationController;

  //TODO create sub pages

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    headerAnimationController =
        AnimationController(vsync: this, duration: defaultDuration);

    headerAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(headerAnimationController!);

    super.initState();
    widget.animationController!.forward();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  void _showAlertDialogQuitCompany(BuildContext context, int permission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.background,
          title: AppLargeText(
              text: permission == 0
                  ? 'Uyarı! İşletmeden ayrılmak mı istiyorsunuz?'
                  : 'Uyarı! İşletmeyi kapatmak mı istiyorsunuz?'),
          content: AppText(
            text: permission == 0
                ? 'Eğer bu işlemi gerçekleştirirseniz, işletmenizden ayrılacak ve bu adım geri alınamaz olacaktır. Bu nedenle, lütfen bu kararı dikkatlice düşünün ve işletmenizle ilgili tüm bilgileri kaydedip yedekleyerek emin olun.'
                : 'İşletmenizi kapatmak, tüm faaliyetlerinizi durduracak ve bu işlem geri alınamaz olacaktır. Kapatma işlemi sonrasında, işletmenize ait verilere ve bilgilere erişim kaybolacak, ve bu süreci geri almak mümkün olmayacaktır.',
            maxLineCount: 10,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: AppText(
                text: 'Vazgeç',
                color: AppTheme.contrastColor1,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: AppText(
                text: 'Ayrılmak İstiyorum!',
                color: AppTheme.alertRed[0],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              AnimatedBuilder(
                animation: widget.animationController!,
                builder: (BuildContext context, Widget? child) {
                  return FadeTransition(
                    opacity: topBarAnimation!,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(
                            top: getPaddingScreenTopHeight() +
                                AppBar().preferredSize.height +
                                paddingHorizontal),
                        child: ListView(
                          shrinkWrap: true,
                          padding: paddingZero,
                          children: [
                            Box_View(
                              boxInside: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: paddingHorizontal),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: User.userProfile!
                                                    .userProfilePhoto)),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: paddingHorizontal),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        paddingHorizontal / 2),
                                                child: AppText(
                                                  text:
                                                      '${User.userProfile!.userName}',
                                                  fontWeight: FontWeight.bold,
                                                  size: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Box_View(
                              boxInside: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppLargeText(
                                      text: 'Kişisel Ayarlar',
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppText(
                                      text:
                                          'İşletmenizin son ayarlamalarını buradan yapabilir, müşterilerinize daha kaliteli bir deneyim sunabilirsiniz.',
                                    ),
                                  ),
                                  SettingsButton(
                                    buttonName: 'Profilim',
                                    buttonOnclick: () {
                                      widget.updatePage!(pageId: 31);
                                    },
                                  ),
                                  SettingsButton(
                                    buttonName: 'Profilimi Düzenle',
                                    buttonOnclick: () {
                                      widget.updatePage!(pageId: 32);
                                    },
                                  ),
                                  SettingsButton(
                                    buttonName: 'Şifreler ve Güvenlik',
                                    buttonOnclick: () {
                                      widget.updatePage!(pageId: 33);
                                    },
                                  ),
                                  SettingsButton(
                                    buttonName: 'Hesap Gizliliği',
                                    buttonOnclick: () {
                                      widget.updatePage!(pageId: 34);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Box_View(
                              boxInside: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppLargeText(
                                      text: 'Araç Ayarları',
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppText(
                                      text:
                                          'Sahip olduğunuz aracı belirterek sizlerde size uygun şarj sürelerini elde edebilirsiniz.',
                                    ),
                                  ),
                                  Box_View(
                                    horizontal: 0,
                                    color: AppTheme.background,
                                    boxInside: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            /* FaIcon(
                                              FontAwesomeIcons.car,
                                              size: 54,
                                              color: AppTheme.textColor,
                                            ), */
                                            Container(
                                              height: 154,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: NetworkContainer(
                                                onLoad: (){},
                                                imageUrl: NetworkImage(
                                                    'https://dev.elektronikey.com/bitirme/brand_logo/tesla.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: paddingHorizontal),
                                              child: Column(
                                                children: [
                                                  AppText(
                                                    text:
                                                        'Aracın Markası : Tesla',
                                                    size: 14,
                                                  ),
                                                  AppText(
                                                    text:
                                                        'Aracın Modeli : Model Y',
                                                    size: 14,
                                                  ),
                                                  AppText(
                                                    text:
                                                        'Aracın Üretim Yılı : 2023',
                                                    size: 14,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SettingsButton(
                                    buttonName: 'Ödeme Geçmişim',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName: 'Ödeme Seçenekleri',
                                    buttonOnclick: () {},
                                  ),
                                ],
                              ),
                            ),
                            Box_View(
                              boxInside: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppLargeText(
                                      text: 'Ödeme Ayarları',
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppText(
                                      text:
                                          'Destekleyen işletmelerin şarj ödemelerini tek tıkla öde!',
                                    ),
                                  ),
                                  SettingsButton(
                                    buttonName: 'Kayıtlı Ödeme Yöntemleri',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName: 'Ödeme Geçmişim',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName: 'Ödeme Seçenekleri',
                                    buttonOnclick: () {},
                                  ),
                                ],
                              ),
                            ),
                            /* Box_View(
                              boxInside: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppText(
                                      text: 'Websitesi Ayarları',
                                      
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppText(
                                      text:
                                          'İşletmenizin son ayarlamalarını buradan yapabilir, müşterilerinize daha kaliteli bir deneyim sunabilirsiniz.',
                                    ),
                                  ),
                                  SettingsButton(
                                    buttonName:
                                        'Kurumsal Websitenizi Ayarları Düzenle',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName:
                                        'Kurumsal Websitenizi Düzenleyin',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName:
                                        'Menü Websitenizin Ayarlarını Düzenleyin',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName:
                                        'Menü Websitesinin Görünürlük Düzenleyin',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName: 'Menü Websitesini Düzenleyin',
                                    buttonOnclick: () {},
                                  ),
                                ],
                              ),
                            ),
                             */
                            Box_View(
                              boxInside: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppLargeText(
                                      text: 'Uygulama Ayarları',
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: paddingHorizontal),
                                    child: AppText(
                                      text:
                                          'İşletmenizin son ayarlamalarını buradan yapabilir, müşterilerinize daha kaliteli bir deneyim sunabilirsiniz.',
                                    ),
                                  ),
                                  SettingsButton(
                                    buttonName: 'Görünüm Ayarları',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName: 'Gizlilik Ayarları',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName: 'Bildirim Ayarları',
                                    buttonOnclick: () {},
                                  ),
                                  SettingsButton(
                                    buttonName: 'Data-Saver Modu',
                                    buttonOnclick: () {
                                      widget.updatePage!(pageId: 44);
                                    },
                                  ),
                                  SettingsButton(
                                    buttonName: 'Dil',
                                    buttonOnclick: () {},
                                  ),
                                ],
                              ),
                            ),
                            Box_View(
                              color: AppTheme.alertRed[0].withOpacity(.4),
                              boxInside: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.x,
                                        size: 14,
                                        color: AppTheme.textColor,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: paddingHorizontal / 2),
                                        child: AppText(
                                          text: 'Hesaptan Çıkış Yap',
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.angleRight,
                                    size: 14,
                                    color: AppTheme.textColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
              /*  Refresh_widget(
                scrollOffset: offset,
                refreshPage: () {},
              ), */
              AnimatedBuilder(
                animation: headerAnimation!,
                builder: (BuildContext context, Widget? child) {
                  return HeaderWidget(
                    headerColor: AppTheme.background.withOpacity(1),
                    blurOpacity: 0,
                    headerIconColor: AppTheme.textColor.withOpacity(1),
                    scaffoldKey: widget.scaffoldKey,
                    updatePage: widget.updatePage!,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.buttonName,
    this.buttonIcon,
    required this.buttonOnclick,
  });

  final String buttonName;
  final IconData? buttonIcon;
  final Function buttonOnclick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => buttonOnclick(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppTheme.textColor.withOpacity(.4)),
            top: BorderSide(color: AppTheme.textColor.withOpacity(.4)),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: paddingHorizontal),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                buttonIcon != null
                    ? FaIcon(
                        buttonIcon,
                        size: 14,
                        color: AppTheme.textColor,
                      )
                    : Container(),
                AppText(
                  text: buttonName,
                  size: 14,
                ),
              ],
            ),
            FaIcon(
              FontAwesomeIcons.angleRight,
              size: 14,
              color: AppTheme.textColor,
            )
          ],
        ),
      ),
    );
  }
}
