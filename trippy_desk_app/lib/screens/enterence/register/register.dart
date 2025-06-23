import 'dart:ui';
import 'package:trippy_desk_app/constants/sizeConfig.dart';
import 'package:trippy_desk_app/constants/theme.dart';
import 'package:trippy_desk_app/screens/enterence/register/components/GendernName.dart';
import 'package:trippy_desk_app/screens/enterence/register/components/confirmationPage.dart';
import 'package:trippy_desk_app/screens/enterence/register/components/mailandPassword.dart';
import 'package:trippy_desk_app/widgets/app_large_text.dart';
import 'package:trippy_desk_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  final AnimationController? animationController;
  final Function updatePage;
  const RegisterScreen(
      {Key? key, this.animationController, required this.updatePage})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  AnimationController? swipeAnimation;
  Animation? animation1, animation2, reload;
  String kullanici_gender = '', kullanici_adsoyad = '';
  String kullanici_mail = '', kullanici_gsm = '', kullanici_password = '';
  PageController _pageController = PageController();

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
                BackgroundAnimatedPics(context),
                Positioned(
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black.withOpacity(.4),
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: SafeArea(
                            top: true,
                            bottom: true,
                            child: PageView(
                              controller: _pageController,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                GenderWidget(
                                  nextPage: (String isim, String gender) {
                                    setState(() {
                                      kullanici_adsoyad = isim;
                                      kullanici_gender = gender;
                                    });
                                    _pageController.nextPage(
                                        duration: defaultDuration,
                                        curve: Curves.easeInOut);
                                    print('${kullanici_adsoyad} - ${gender}');
                                  },
                                ),
                                MailandPassword(
                                  kullanici_adsoyad: kullanici_adsoyad,
                                  nextPage: (String mail, String gsm,
                                      String password) {
                                    setState(() {
                                      kullanici_mail = mail;
                                      kullanici_gsm = gsm;
                                      kullanici_password = password;
                                    });
                                    _pageController.nextPage(
                                        duration: defaultDuration,
                                        curve: Curves.easeInOut);
                                  },
                                ),
                                ConfimationPage(
                                  confirmationNumber: 1122,
                                  nextPage: () {
                                    widget.updatePage(pageId: 94);
                                  },
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

  Container BackgroundAnimatedPics(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
              child: ListView.builder(
                itemCount: 4,
                padding: paddingZero,
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
                                  image: AssetImage(welcomePhotos[0][index]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
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
              padding: EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
              child: ListView.builder(
                itemCount: 4,
                padding: paddingZero,
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
                                  image: AssetImage(welcomePhotos[1][index]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
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
              padding: EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
              child: ListView.builder(
                itemCount: 4,
                padding: paddingZero,
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
                                  image: AssetImage(welcomePhotos[2][index]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
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
    );
  }
}
