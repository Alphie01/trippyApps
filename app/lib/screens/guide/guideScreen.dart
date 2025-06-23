import 'package:TrippyAlpapp/core/classes/bloc/opacity_cubit.dart';
import 'package:TrippyAlpapp/screens/guide/components/bottomModalInfo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TrippyAlpapp/core/classes/bloc/maps_cubit.dart';
import 'package:TrippyAlpapp/core/classes/bloc/routeResult_cubit.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/screens/guide/components/maps.dart';
import 'package:flutter/material.dart';
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
  LatLng? currPosition;

  bool fullscreenMap = false;
  DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();

  Animation<double>? mapAnimation, listAnimation, listOpacity;
  AnimationController? mapAnimationController, listAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    listAnimationController =
        AnimationController(vsync: this, duration: defaultDuration);
    listAnimation = Tween<double>(begin: 100, end: SizeConfig.screenHeight / 2)
        .animate(listAnimationController!);
    listOpacity =
        Tween<double>(begin: 0, end: 1).animate(listAnimationController!);
    mapAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(mapAnimationController!);

    draggableScrollableController.addListener(() {
      context.read<OpacityCubit>().setState(draggableScrollableController.size);
    });
    widget.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MapsPolylinesCubit(),
        ),
        BlocProvider(
          create: (_) => RouteResultCubit(),
        ),
      ],
      child: AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
            opacity: widget.animation!,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation!.value), 0.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height,
                    child: Maps(
                      latLng: LatLng(40.22570592673382, 28.912402317623727),
                      showSearch: false,
                      setUserLoc: (LatLng position) {
                        setState(() {
                          currPosition = position;
                        });
                      },
                    ),
                  ),
                  BottomInfoBar(
                    draggableScrollableController:
                        draggableScrollableController,
                  ),
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
