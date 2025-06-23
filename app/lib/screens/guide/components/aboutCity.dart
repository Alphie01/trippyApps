import 'dart:ui';
import 'package:TrippyAlpapp/core/classes/bloc/current_placemark_cubit.dart';
import 'package:TrippyAlpapp/core/classes/bloc/maps_cubit.dart';
import 'package:TrippyAlpapp/core/classes/cities.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/screens/guide/components/cityNavigation.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/networkImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';

class SearchCityPage extends StatefulWidget {
  const SearchCityPage({super.key});

  @override
  State<SearchCityPage> createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation,
      opacityAnimation,
      containerAnimation,
      searchAnimation;
  bool searchBool = true;
  PageController? pageController;
  bool isBackgroundLoaded = false;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    pageController = PageController();
    animationController =
        AnimationController(vsync: this, duration: defaultDuration);

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
  void dispose() {
    animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkContainer(
      onLoad: () {
        animationController!.forward();
      },
      imageUrl: Cities.selectedCites.cityPhotos.first,
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
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              top: getPaddingScreenTopHeight(),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Transform.translate(
                      offset: Offset(-1, 0),
                      child: AnimatedBuilder(
                        animation: animationController!,
                        builder: (BuildContext context, Widget? child) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(
                                      MediaQuery.of(context).size.width)),
                              border: Border.all(
                                color: AppTheme.textColor
                                    .withOpacity(containerAnimation!.value),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(
                                        MediaQuery.of(context).size.width)),
                              ),
                              child: Opacity(
                                opacity: containerAnimation!.value,
                                child: GestureDetector(
                                  onTap: () {
                                    //TODO Şehir Seç
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (contexted) {
                                        return Container();
                                      },
                                    );
                                  },
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
                                          text: '${Cities.selectedCites.cityName}',
                                          size: 32,
                                        ),
                                        Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.search,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            AppLargeText(text: 'Şehir Belirle')
                                          ],
                                        ),
                                        Container(
                                          height: 1,
                                          width: double.maxFinite,
                                          margin: EdgeInsets.only(
                                              top: paddingHorizontal,
                                              bottom: paddingHorizontal,
                                              right: 2 * paddingHorizontal),
                                          decoration: BoxDecoration(
                                              color: AppTheme.textColor),
                                        ),
                                        AppLargeText(
                                          text:
                                              todayString(currentDate.weekday),
                                        ),
                                        AppLargeText(
                                          text:
                                              '${monthString(currentDate.month)}, ${currentDate.day} ${currentDate.year}',
                                        ),
                                        Container(
                                          height: 1,
                                          width: double.maxFinite,
                                          margin: EdgeInsets.only(
                                              top: paddingHorizontal,
                                              bottom: paddingHorizontal,
                                              right: 2 * paddingHorizontal),
                                          decoration: BoxDecoration(
                                              color: AppTheme.textColor),
                                        ),
                                        Row(
                                          children: [
                                            FaIcon(
                                              Cities.selectedCites.cityWeather
                                                  .weatherIcon,
                                              color: AppTheme.textColor,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: paddingHorizontal),
                                              child: AppLargeText(
                                                  text:
                                                      '${Cities.selectedCites.cityWeather.weatherName}'),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 1,
                                          width: double.maxFinite,
                                          margin: EdgeInsets.only(
                                              top: paddingHorizontal,
                                              bottom: paddingHorizontal,
                                              right: 2 * paddingHorizontal),
                                          decoration: BoxDecoration(
                                              color: AppTheme.textColor),
                                        ),
                                        Container(
                                          child: AppLargeText(
                                              text:
                                                  '${Cities.selectedCites.cityWeatherCelsius} °C'),
                                        ),
                                      ],
                                    ),
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
                      builder: (BuildContext context, Widget? child) {
                        return Opacity(
                          opacity: containerAnimation!.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.translate(
                                offset: Offset(-4.5 * paddingHorizontal, 0),
                                child: CityNavigation(
                                  navigationFunction: () {
                                    /* showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  clipBehavior: Clip.hardEdge,
                                                  builder: (ctx) {
                                                    return SearchCityDesc(
                                                      closeModal: () {
                                                        Navigator.pop(context);
                                                      },
                                                      backToFirst: () {
                                                        pageController!
                                                            .animateToPage(0,
                                                                duration:
                                                                    defaultDuration,
                                                                curve: Curves
                                                                    .easeInOut);
                                                      },
                                                    );
                                                  }); */
                                  },
                                  navigationName: 'Hakkında',
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(-1.5 * paddingHorizontal, 0),
                                child: CityNavigation(
                                  navigationFunction: () {
                                    /* showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return Search_city_deger();
                                                },
                                              ); */
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
                                offset: Offset(-1.5 * paddingHorizontal, 0),
                                child: CityNavigation(
                                  navigationFunction: () {
                                    pageController!.animateToPage(1,
                                        duration: defaultDuration,
                                        curve: Curves.easeInOut);
                                  },
                                  navigationName: 'Fotoğraflar',
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(-4.5 * paddingHorizontal, 0),
                                child: CityNavigation(
                                  navigationFunction: () {
                                    pageController!.animateToPage(1,
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
          )
        ],
      ),
    );
  }
}
