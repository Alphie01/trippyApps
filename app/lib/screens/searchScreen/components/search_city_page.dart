import 'dart:ui';

import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/cityGuide/cities.dart';
import 'package:TrippyAlpapp/screens/searchScreen/components/classes/city/search_city_desc.dart';
import 'package:TrippyAlpapp/screens/searchScreen/components/classes/city/cityNavigation.dart';
import 'package:TrippyAlpapp/widgets/app_large_text.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchCityPage extends StatefulWidget {
  const SearchCityPage({super.key});

  @override
  State<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage>
    with TickerProviderStateMixin {
  AnimationController? animationController,
      textAnimationController,
      searchAnimationController;
  Animation<double>? animation,
      opacityAnimation,
      containerAnimation,
      searchAnimation;
  bool searchBool = true;
  PageController? pageController;
  FocusNode _focusNode = FocusNode();
  ImageProvider _imageProvider = Cities.selectedCites.cityPhotos[1];
  bool isBackgroundLoaded = false;
  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
      } else {}
    });

    _imageProvider.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, synchronousCall) {
        if (mounted) {
          setState(() {
            isBackgroundLoaded = true; // Yükleme tamamlandı
          });
          Future.delayed(Duration(seconds: 2), () {
            animationController!.forward();
          });
        }
      }),
    );
    pageController = PageController();

    animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    textAnimationController =
        AnimationController(vsync: this, duration: defaultDuration);
    searchAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    searchAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(searchAnimationController!);
    //bg Animation
    animation =
        Tween<double>(begin: 0.0, end: 5.0).animate(animationController!);
    opacityAnimation =
        Tween<double>(begin: 0.0, end: 0.6).animate(animationController!);
    containerAnimation =
        Tween<double>(begin: 0.0, end: 1).animate(animationController!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: isBackgroundLoaded
          ? PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    image: DecorationImage(
                        image: _imageProvider, fit: BoxFit.cover),
                  ),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      AnimatedBuilder(
                        animation: animationController!,
                        builder: (BuildContext context, Widget? child) {
                          return ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: animation!.value,
                                sigmaY: animation!.value,
                              ),
                              child: Container(
                                width: double.maxFinite,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: AppTheme.background
                                      .withOpacity(opacityAnimation!.value),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SafeArea(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                            top: getPaddingSreenTopHeight(),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Transform.translate(
                                    offset: Offset(-1, 0),
                                    child: AnimatedBuilder(
                                      animation: animationController!,
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    right: Radius.circular(
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width)),
                                            border: Border.all(
                                              color: AppTheme.textColor
                                                  .withOpacity(
                                                      containerAnimation!
                                                          .value),
                                            ),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      right: Radius.circular(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width)),
                                            ),
                                            child: Opacity(
                                              opacity:
                                                  containerAnimation!.value,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: paddingHorizontal),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AppLargeText(
                                                        text: Cities
                                                            .selectedCites
                                                            .cityName),
                                                    Container(
                                                      height: 1,
                                                      width: double.maxFinite,
                                                      margin: EdgeInsets.only(
                                                          top:
                                                              paddingHorizontal,
                                                          bottom:
                                                              paddingHorizontal,
                                                          right: 2 *
                                                              paddingHorizontal),
                                                      decoration: BoxDecoration(
                                                          color: AppTheme
                                                              .textColor),
                                                    ),
                                                    AppText(
                                                      text: 'Pazartesi,',
                                                      size: 18,
                                                    ),
                                                    AppText(
                                                      text: 'Ağustos, 10, 2023',
                                                      size: 18,
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      width: double.maxFinite,
                                                      margin: EdgeInsets.only(
                                                          top:
                                                              paddingHorizontal,
                                                          bottom:
                                                              paddingHorizontal,
                                                          right: 2 *
                                                              paddingHorizontal),
                                                      decoration: BoxDecoration(
                                                          color: AppTheme
                                                              .textColor),
                                                    ),
                                                    Row(
                                                      children: [
                                                        FaIcon(
                                                          Cities
                                                              .selectedCites
                                                              .cityWeather
                                                              .weatherIcon,
                                                          color: AppTheme
                                                              .textColor,
                                                          size: 18,
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left:
                                                                  paddingHorizontal),
                                                          child: AppText(
                                                              size: 18,
                                                              text:
                                                                  '${Cities.selectedCites.cityWeather.weatherName}'),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      width: double.maxFinite,
                                                      margin: EdgeInsets.only(
                                                          top:
                                                              paddingHorizontal,
                                                          bottom:
                                                              paddingHorizontal,
                                                          right: 2 *
                                                              paddingHorizontal),
                                                      decoration: BoxDecoration(
                                                          color: AppTheme
                                                              .textColor),
                                                    ),
                                                    Container(
                                                      child: AppText(
                                                          size: 18,
                                                          text:
                                                              '${Cities.selectedCites.cityWeatherCelsius} °C'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: MediaQuery.of(context).size.width,
                                  child: AnimatedBuilder(
                                    animation: animationController!,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Opacity(
                                        opacity: containerAnimation!.value,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Transform.translate(
                                              offset: Offset(
                                                  -4.5 * paddingHorizontal, 0),
                                              child: CityNavigation(
                                                navigationFunction: () {
                                                  pageController!.animateToPage(
                                                      1,
                                                      duration: defaultDuration,
                                                      curve: Curves.easeInOut);
                                                },
                                                navigationName: 'Hakkında',
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  -1.5 * paddingHorizontal, 0),
                                              child: CityNavigation(
                                                navigationFunction: () {
                                                  pageController!.animateToPage(
                                                      1,
                                                      duration: defaultDuration,
                                                      curve: Curves.easeInOut);
                                                },
                                                navigationName: 'Değerlendirme',
                                              ),
                                            ),
                                            CityNavigation(
                                              navigationFunction: () {
                                                pageController!.animateToPage(1,
                                                    duration: defaultDuration,
                                                    curve: Curves.easeInOut);
                                              },
                                              navigationName: 'Meşhur',
                                            ),
                                            CityNavigation(
                                              navigationFunction: () {
                                                pageController!.animateToPage(1,
                                                    duration: defaultDuration,
                                                    curve: Curves.easeInOut);
                                              },
                                              navigationName: 'Rehber',
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  -1.5 * paddingHorizontal, 0),
                                              child: CityNavigation(
                                                navigationFunction: () {
                                                  pageController!.animateToPage(
                                                      1,
                                                      duration: defaultDuration,
                                                      curve: Curves.easeInOut);
                                                },
                                                navigationName: 'Fotoğraflar',
                                              ),
                                            ),
                                            Transform.translate(
                                              offset: Offset(
                                                  -4.5 * paddingHorizontal, 0),
                                              child: CityNavigation(
                                                navigationFunction: () {
                                                  pageController!.animateToPage(
                                                      1,
                                                      duration: defaultDuration,
                                                      curve: Curves.easeInOut);
                                                },
                                                navigationName: 'Hava Durumu',
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: searchAnimationController!,
                        builder: (BuildContext context, Widget? child) {
                          return Container(
                            height: searchBool
                                ? AppBar().preferredSize.height
                                : MediaQuery.of(context).size.height,
                            margin: EdgeInsets.only(
                                top: getPaddingSreenTopHeight() + 25,
                                left: paddingHorizontal,
                                right: paddingHorizontal),
                            color: AppTheme.background
                                .withOpacity(searchAnimation!.value),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: paddingHorizontal),
                              height: AppBar().preferredSize.height,
                              child: searchBool
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.globe,
                                              size: 18,
                                              color: AppTheme.textColor,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                searchAnimationController!
                                                    .forward()
                                                    .then((value) {
                                                  setState(() {
                                                    searchBool = false;
                                                  });
                                                });
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: AppLargeText(
                                                  text: Cities
                                                      .selectedCites.cityName,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            searchAnimationController!
                                                .forward()
                                                .then((value) {
                                              setState(() {
                                                searchBool = false;
                                              });
                                            });
                                          },
                                          child: Container(
                                            child: FaIcon(
                                              FontAwesomeIcons.search,
                                              size: 18,
                                              color: AppTheme.textColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : ListView(
                                      padding: paddingZero,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: TextField(
                                                /* controller: _editingController, */
                                                onChanged: (news) {},
                                                focusNode: _focusNode,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppTheme.textColor),
                                                cursorColor: AppTheme.textColor,
                                                decoration: InputDecoration(
                                                  hintText: "Aramak için ....",
                                                  hintStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade500),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: AppTheme
                                                                  .textColor)),
                                                  fillColor: Colors.transparent,
                                                  filled: true,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  searchAnimationController!
                                                      .reverse()
                                                      .then((value) {
                                                    setState(() {
                                                      searchBool = true;
                                                    });
                                                  });
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.xmark,
                                                  color: AppTheme.textColor,
                                                ),
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: paddingHorizontal),
                                          child: AppText(
                                              text:
                                                  'Daha Önceden Aradığın Şehirler'),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: paddingZero,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: 36,
                                          itemBuilder: (ctx, index) {
                                            return AppText(
                                                text: 'sehir${index}');
                                          },
                                        )
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                //Hakkında
                SearchCityDesc()
              ],
            )
          : Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(color: AppTheme.firstColor,),
              ),
            ),
    );
  }
}
