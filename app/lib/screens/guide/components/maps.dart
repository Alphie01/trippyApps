import 'dart:async';
import 'dart:math';
import 'package:TrippyAlpapp/core/classes/permissions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:TrippyAlpapp/core/classes/bloc/maps_cubit.dart';
import 'package:TrippyAlpapp/core/classes/maps.dart';
import 'package:TrippyAlpapp/core/constants/sizeconfig.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/core/sharedPref/sharedpreferences.dart';
import 'package:TrippyAlpapp/core/sharedPref/sharedprefkeynames.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;

class Maps extends StatefulWidget {
  final LatLng? latLng;
  final bool showSearch;
  final Function? goBackNavigation, createIstasyonInfoList;
  final Function(LatLng pos)? setUserLoc;

  const Maps(
      {Key? key,
      required this.latLng,
      required this.showSearch,
      this.goBackNavigation,
      this.createIstasyonInfoList,
      this.setUserLoc})
      : super(key: key);

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> with TickerProviderStateMixin {
  Set<Marker> _markers = {};

  late GoogleMapController mapController;
  AnimationController? searchField;
  Animation<double>? fieldOpacity, fieldTransform;
  bool fieldSeen = false, onLoadingField = false;

  bool fullscreenMap = false;

  Animation<double>? mapAnimation,
      listAnimation,
      listOpacity,
      buttonOpacity,
      routeOpacity;
  AnimationController? mapAnimationController,
      listAnimationController,
      buttonAnimationController,
      routeAnimationController;

  // Object for PolylinePoints
  late PolylinePoints polylinePoints;

// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  LatLng _location = LatLng(0, 0);

  BitmapDescriptor bitmapDescriptor = BitmapDescriptor.defaultMarker;

  bool isFetchedCurrentLocation = false, isDisplayStations = true;

  Position? _currentPosition;

  @override
  void initState() {
    listAnimationController =
        AnimationController(vsync: this, duration: defaultDuration);
    listAnimation = Tween<double>(begin: 100, end: SizeConfig.screenHeight / 2)
        .animate(listAnimationController!);
    listOpacity =
        Tween<double>(begin: 0, end: 1).animate(listAnimationController!);
    buttonAnimationController =
        AnimationController(vsync: this, duration: defaultDuration);
    routeAnimationController =
        AnimationController(vsync: this, duration: defaultDuration);
    buttonOpacity =
        Tween<double>(begin: 1, end: 0).animate(buttonAnimationController!);
    routeOpacity =
        Tween<double>(begin: 1, end: 0).animate(routeAnimationController!);
    super.initState();
    searchField = AnimationController(vsync: this, duration: defaultDuration);
    fieldOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(searchField!);
    fieldTransform =
        Tween<double>(begin: -150.0, end: 0.0).animate(searchField!);
  }

  Future<void> createMarkers(Position position) async {
    Set<Marker> marks = await MapsMarker.createListOfMarker(
        position.latitude, position.longitude, context);
    setState(() {
      _markers = marks;
    });
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await Permissions.handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        isFetchedCurrentLocation = true;
        createMarkers(position);
        widget.setUserLoc!(LatLng(position.latitude, position.longitude));
      });
      directPosition(position: position);
      context.read<CurrentPlacemarkCubit>().getAddressFromLatLng(position);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> directPosition(
      {required Position position, double? zoom}) async {
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: zoom ?? 16),
      ),
    );
  }

  void fetchNewPlaces() {
    setState(() {
      onLoadingField = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        onLoadingField = false;
      });
    });
  }

  void dispose() {
    mapController!.dispose();
    super.dispose();
  }

  void _getVisibleRegionCoordinates(CameraPosition position) async {
    LatLngBounds visibleRegion = await mapController.getVisibleRegion();
    LatLng northeast = visibleRegion.northeast;
    LatLng southwest = visibleRegion.southwest;

    if (northeast.latitude > _currentPosition!.latitude &&
        _currentPosition!.latitude > southwest.latitude &&
        northeast.longitude > _currentPosition!.longitude &&
        _currentPosition!.longitude > southwest.longitude) {
      searchField!.reverse().then((value) {
        setState(() {
          fieldSeen = false;
        });
      });
    } else {
      setState(() {
        fieldSeen = true;
      });
      searchField!.forward();
    }
  }

  void _goCurrentLocation() async {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 16.0,
      ),
    ));
  }

  double calculateZoomLevel(
      LatLng userLocation, LatLng destination, BuildContext context) {
    double south, west, east, north;

    if (userLocation.latitude <= destination.latitude) {
      south = userLocation.latitude;
      north = destination.latitude;
    } else {
      south = destination.latitude;
      north = userLocation.latitude;
    }

    if (userLocation.longitude <= destination.longitude) {
      west = userLocation.longitude;
      east = destination.longitude;
    } else {
      west = destination.longitude;
      east = userLocation.longitude;
    }

    double width = east - west;
    double height = north - south;

    Size screenSize = MediaQuery.of(context).size;

    double zoomWidth = _calculateZoom(width, screenSize.width);
    double zoomHeight = _calculateZoom(height, screenSize.height);
    return min(zoomWidth, zoomHeight);
  }

  double _calculateZoom(double dimension, double viewportDimension) {
    const double worldDimension = 256;
    int numTiles = (dimension * worldDimension / viewportDimension).ceil();
    return _log2(worldDimension * 2 / numTiles);
  }

  double _log2(double x) => log(x) / log(2);

  String rotaSuresi(int? saniye) {
    if (saniye == null || saniye <= 0) {
      return "Geçersiz süre";
    }

    int saat = saniye ~/ 3600;
    int dakika = (saniye % 3600) ~/ 60;
    int kalanSaniye = saniye % 60;

    if (saat < 1) {
      if (dakika < 1) {
        return '$kalanSaniye saniye';
      } else {
        return '$dakika dakika';
      }
    } else {
      return '$saat saat';
    }
  }

  Widget emptyBody = Container(
    color: AppTheme.background,
    alignment: Alignment.center,
    child: Container(
      width: 75,
      height: 75,
      child: CircularProgressIndicator(
        color: AppTheme.contrastColor1,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPositionCubit, Position?>(
      builder: (context, positionCubit) {
        return BlocBuilder<MapsPolylinesCubit, Map<PolylineId, Polyline>>(
          builder: (context, polygons) {
            routeAnimationController!.forward().then((value) {
              isDisplayStations = polygons.isEmpty;
              routeAnimationController!.reverse();
            });
            return GoogleMap(
              onTap: (position) {},
              onCameraMove: (CameraPosition position) {
                /*  _getVisibleRegionCoordinates(position); */
              },
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  mapController = controller;
                });
                if (SharedPref.getBoolValuesSF(darkOrLightMode)) {
                  rootBundle
                      .loadString('assets/map.json')
                      .then((String mapStyle) {
                    controller.setMapStyle(mapStyle);
                  });
                } else {
                  rootBundle
                      .loadString('assets/map_light.json')
                      .then((String mapStyle) {
                    controller.setMapStyle(mapStyle);
                  });
                }
                getCurrentPosition();
              },
              polylines: Set<Polyline>.of(polygons.values),
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(positionCubit!.latitude, positionCubit.longitude),
                zoom: 6,
              ),
              tiltGesturesEnabled: false,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              circles: Set.from(
                [
                  Circle(
                    circleId: CircleId('currentCircle'),
                    center: LatLng(_location.latitude, _location.longitude),
                    radius: 4000,
                    fillColor: Colors.blue.shade100.withOpacity(0.5),
                    strokeColor: Colors.blue.shade100.withOpacity(0.1),
                  ),
                ],
              ),
              scrollGesturesEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
            );
          },
        );
      },
    );
  }
}
