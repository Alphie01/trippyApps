import 'package:TrippyAlpapp/core/classes/bloc/opacity_cubit.dart';
import 'package:TrippyAlpapp/core/classes/bloc/routeResult_cubit.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/screens/guide/components/aboutCity.dart';
import 'package:TrippyAlpapp/screens/guide/components/places.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:TrippyAlpapp/widgets/box_view.dart';
import 'package:TrippyAlpapp/widgets/networkImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomInfoBar extends StatelessWidget {
  const BottomInfoBar({
    super.key,
    required this.draggableScrollableController,
  });

  final DraggableScrollableController draggableScrollableController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteResultCubit, PolylineResult>(
      builder: (BuildContext context, state) {
        if (state.points.isEmpty) {
          return DraggableScrollableSheet(
            controller: draggableScrollableController,
            initialChildSize: .5,
            maxChildSize: 1,
            minChildSize: .12,
            builder: (_, controller) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: BlocBuilder<OpacityCubit, double>(
                  builder: (BuildContext ctx, double opacityState) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(paddingHorizontal),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        bottom: getPaddingScreenBottomHeight(),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: paddingHorizontal),
                        controller: controller,
                        children: [
                          Box_View(
                            boxInside: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      draggableScrollableController.animateTo(
                                        .5,
                                        duration: defaultDuration,
                                        curve: defaultCurve,
                                      );
                                    },
                                    child: AppLargeText(
                                        text: 'Şehiri Keşfetmeye Hazır Mısın?'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    draggableScrollableController.animateTo(
                                      1,
                                      duration: defaultDuration,
                                      curve: defaultCurve,
                                    );
                                    //TODO : SEARCH BAR
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.search,
                                    color: AppTheme.textColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          GridView.count(
                            crossAxisSpacing: paddingHorizontal,
                            mainAxisSpacing: paddingHorizontal,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingHorizontal,
                                vertical: paddingHorizontal * .5),
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              InfoGridButtons(
                                buttonText: 'Kendimi Şanslı Hissediyorum',
                                buttonIcon: FontAwesomeIcons.dice,
                              ),
                              InfoGridButtons(
                                buttonFunction: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (ctxt) {
                                      return AboutYourCity();
                                    },
                                  );
                                },
                                buttonText: 'Şehrimi Tanımak İstiyorum',
                                buttonIcon: FontAwesomeIcons.city,
                              ),
                              InfoGridButtons(
                                buttonFunction: () {},
                                buttonText: 'Tarih',
                                buttonIcon: FontAwesomeIcons.city,
                              ),
                              InfoGridButtons(
                                buttonFunction: () {},
                                buttonText: 'Turistik',
                                buttonIcon: FontAwesomeIcons.city,
                              ),
                            ],
                          ),
                          WentBefore(),
                          Box_View(
                            boxInside: Column(
                              children: [
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color: AppTheme.textColor,
                                      size: 14,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: paddingHorizontal * .5),
                                      child: AppLargeText(
                                        text: 'Sevebileceklerin',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Places(),
                          Box_View(
                            boxInside: Column(
                              children: [
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.ticket,
                                      color: AppTheme.textColor,
                                      size: 14,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: paddingHorizontal * .5),
                                      child: AppLargeText(
                                        text: 'Konaklama',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Box_View(
                            boxInside: Column(
                              children: [
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.ticket,
                                      color: AppTheme.textColor,
                                      size: 14,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: paddingHorizontal * .5),
                                      child: AppLargeText(
                                        text: 'Sana Özel Yaklaşan Etkinlikler',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class AboutYourCity extends StatelessWidget {
  const AboutYourCity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(color: AppTheme.background, child: SearchCityPage());
      },
    );
  }
}

class InfoGridButtons extends StatelessWidget {
  const InfoGridButtons({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    this.buttonFunction,
  });
  final String buttonText;
  final IconData buttonIcon;
  final Function? buttonFunction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buttonFunction!();
      },
      child: Box_View(
        vertical: 0,
        horizontal: 0,
        color: AppTheme.contrastColor1.withOpacity(.3),
        boxInside: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaIcon(
              buttonIcon,
              color: AppTheme.textColor.withOpacity(.6),
              size: 44,
            ),
            Container(
              padding: EdgeInsets.only(
                top: paddingHorizontal,
              ),
              child: AppText(
                text: buttonText,
                fontWeight: FontWeight.bold,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WentBefore extends StatelessWidget {
  const WentBefore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Box_View(
      boxInside: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.solidStar,
                color: AppTheme.textColor,
                size: 14,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: paddingHorizontal / 2),
                  child: AppLargeText(
                    text: 'Gittiklerim',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: paddingHorizontal),
            height: 150,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              padding: paddingZero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return RateBeforePlace();
              },
            ),
          )
        ],
      ),
    );
  }
}

class RateBeforePlace extends StatelessWidget {
  const RateBeforePlace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      margin: EdgeInsets.only(right: paddingHorizontal),
      child: NetworkContainer(
        onLoad: () {},
        imageUrl: NetworkImage(
            'https://images.pexels.com/photos/18671861/pexels-photo-18671861/free-photo-of-peyzaj-manzara-daglar-bulutlu.jpeg'),
        child: Container(
          color: AppBlackTheme.background.withOpacity(.4),
          padding: EdgeInsets.all(paddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    AppText(
                      text:
                          'Mekan İsmi Mekan İsmiMekan İsmiMekan İsmiMekan İsmiMekan İsmi',
                      maxLineCount: 2,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.filter,
                          color: AppTheme.textColor,
                          size: 12,
                        ),
                        Container(
                            padding:
                                EdgeInsets.only(left: paddingHorizontal * .5),
                            child: AppText(text: 'Kategori'))
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(paddingHorizontal),
                        color: AppTheme.contrastColor1),
                    padding: EdgeInsets.all(paddingHorizontal / 2),
                    child: AppText(
                      text: 'Değerlendir',
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
