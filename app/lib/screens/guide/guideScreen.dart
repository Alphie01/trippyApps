import 'dart:math';

import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/classes/cityGuide/place_categories.dart';
import 'package:TrippyAlpapp/screens/guide/components/maps.dart';
import 'package:TrippyAlpapp/screens/guide/components/modalPage.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewScreen extends StatefulWidget {
  final Function? updatePage;
  final AnimationController? animationController;
  final Animation<double>? animation;
  const MapViewScreen({
    Key? key,
    this.animation,
    this.animationController,
    this.updatePage,
  }) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen>
    with TickerProviderStateMixin {
  //final Animation<double>? _animation;
  PageController _pageController = PageController();

  bool fullscreenMap = false;

  bool _placesGridview = false;
  Animation<double>? mapAnimation, listAnimation;
  AnimationController? mapAnimationController, listAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    listAnimationController =
        AnimationController(vsync: this, duration: defaultDuration);
    listAnimation = Tween<double>(begin: 100, end: SizeConfig.screenHeight)
        .animate(listAnimationController!);
    mapAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(mapAnimationController!);

    

    widget.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation!.value), 0.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height,
                  child: Maps(
                      latLng: LatLng(40.22570592673382, 28.912402317623727),
                      showSearch: false),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return MapsModalPage(
                            closeNavigator: () {
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(
                        top: getPaddingSreenTopHeight(),
                        left: paddingHorizontal,
                        right: paddingHorizontal,
                        bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(15)),
                        color: AppTheme.background),
                    child: AppText(
                      text: 'Deneme  ',
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
