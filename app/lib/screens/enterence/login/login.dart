import 'dart:ui';
import 'package:app/constants/sharedPreferencesKeynames.dart';
import 'package:app/constants/theme.dart';
import 'package:app/core/sharedPreferences.dart';
import 'package:app/widgets/app_large_text.dart';
import 'package:app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  final AnimationController? animationController;
  final Function? updatePage;
  const LoginScreen({Key? key, this.animationController, this.updatePage})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController? swipeAnimation;
  Animation? animation1, animation2, reload;

  List welcomePhotos = [
    [
      'assets/welcome/1.jpg',
      'assets/welcome/2.jpg',
      'assets/welcome/3.jpg',
      'assets/welcome/4.jpg',
    ],
    [
      'assets/welcome/5.jpg',
      'assets/welcome/6.jpg',
      'assets/welcome/7.jpg',
      'assets/welcome/8.jpg',
    ],
    [
      'assets/welcome/9.jpg',
      'assets/welcome/10.jpg',
      'assets/welcome/11.jpg',
      'assets/welcome/12.jpg',
    ],
  ];

  @override
  void initState() {
    swipeAnimation = AnimationController(
        duration: Duration(seconds: 8), vsync: this)
      ..addListener(() {
        if (swipeAnimation!.isCompleted) {
          swipeAnimation!.reverse().then((value) => swipeAnimation!.repeat());
        }
      });

    animation1 = Tween<double>(begin: 0, end: -150).animate(swipeAnimation!);
    animation2 = Tween<double>(begin: -150, end: 0).animate(swipeAnimation!);
    reload = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: widget.animationController!, curve: Curves.fastOutSlowIn));

    // TODO: implement initState
    super.initState();
    widget.animationController!.forward();
  }

  @override
  void dispose() {
    swipeAnimation!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    swipeAnimation!.forward();
    widget.animationController!.forward();
    return AnimatedBuilder(
      animation: reload!,
      builder: ((context, child) {
        return Opacity(
          opacity: reload!.value,
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, left: 5, right: 5, bottom: 15),
                          child: ListView.builder(
                            itemCount: 4,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return AnimatedBuilder(
                                animation: animation1!,
                                builder: ((context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, animation1!.value),
                                    child: Container(
                                      height: 250,
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  welcomePhotos[0][index]),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, left: 5, right: 5, bottom: 15),
                          child: ListView.builder(
                            itemCount: 4,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return AnimatedBuilder(
                                animation: animation2!,
                                builder: ((context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, animation2!.value),
                                    child: Container(
                                      height: 250,
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  welcomePhotos[1][index]),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15, left: 5, right: 5, bottom: 15),
                          child: ListView.builder(
                            itemCount: 4,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return AnimatedBuilder(
                                animation: animation1!,
                                builder: ((context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, animation1!.value),
                                    child: Container(
                                      height: 250,
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  welcomePhotos[2][index]),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.85),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: SafeArea(
                          top: true,
                          bottom: true,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 5,
                                left: 25,
                                right: 25),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: AppLargeText(
                                    text: 'Şehir Kılavuzu Logo',
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 25, bottom: 10),
                                  child: AppText(
                                    text: 'E-Mail Adresiniz',
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: TextField(
                                    onChanged: (news) {},
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText:
                                          "E-Mail Adresiniz, Telefon Numaranız",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade500),
                                      filled: true,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.firstColor
                                                  .withOpacity(.3))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.firstColor
                                                  .withOpacity(1))),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: AppText(
                                    text: 'Şifreniz',
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 25),
                                  child: TextField(
                                    onChanged: (news) {},
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Şifreniz",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade500),
                                      filled: true,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.firstColor
                                                  .withOpacity(.3))),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.firstColor
                                                  .withOpacity(1))),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(15),
                                  alignment: Alignment.center,
                                  child: AppLargeText(
                                    text: 'Giriş Yap',
                                    color: AppTheme.background,
                                    size: 16,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppTheme.firstColor)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.updatePage!(pageId: 93);
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: 15, bottom: 25),
                                    width: double.maxFinite,
                                    padding: EdgeInsets.all(15),
                                    alignment: Alignment.center,
                                    child: AppLargeText(
                                      text: 'Kayıt Ol',
                                      color: AppTheme.background,
                                      size: 16,
                                    ),
                                    decoration: BoxDecoration(
                                        color: AppTheme.firstColor),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    SharedPref.addStringToSF(userToken, 'value');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 25),
                                    width: double.maxFinite,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color: AppTheme.firstColor))),
                                    child: AppText(
                                      size: 12,
                                      text:
                                          'Sosyal Medya İle Giriş Yapmak İçin',
                                      color:
                                          AppTheme.background.withOpacity(.7),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      socialLoginButton(
                                          FontAwesomeIcons.google),
                                      socialLoginButton(
                                          FontAwesomeIcons.twitter),
                                      socialLoginButton(
                                          FontAwesomeIcons.instagram),
                                      socialLoginButton(
                                          FontAwesomeIcons.linkedin),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Container socialLoginButton(IconData fontAwesomeIcons) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: AppTheme.firstColor)),
      child: FaIcon(
        fontAwesomeIcons,
        color: Colors.white.withOpacity(.5),
      ),
    );
  }
}
