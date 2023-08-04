import 'dart:async';

import 'package:TrippyAlpapp/constants/sharedPreferencesKeynames.dart';
import 'package:TrippyAlpapp/constants/sizeConfig.dart';
import 'package:TrippyAlpapp/constants/theme.dart';
import 'package:TrippyAlpapp/core/sharedPreferences.dart';
import 'package:TrippyAlpapp/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;

class Maps extends StatefulWidget {
  final LatLng latLng;
  final bool showSearch;
  final Function? goBackNavigation;

  const Maps(
      {Key? key,
      required this.latLng,
      required this.showSearch,
      this.goBackNavigation})
      : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> with TickerProviderStateMixin {
  Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;
  GoogleMapController? mapController;
  AnimationController? searchField;
  Animation<double>? fieldOpacity, fieldTransform;
  bool fieldSeen = false, onLoadingField = false;

  late CameraPosition _initalCameraPosition;

  LatLng _location = LatLng(0, 0);

  Location? _currentLocation;

  late Location _locationService;
  BitmapDescriptor bitmapDescriptor = BitmapDescriptor.defaultMarker;

  bool isFetchedCurrentLocation = false;

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    searchField = AnimationController(vsync: this, duration: defaultDuration);
    fieldOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(searchField!);
    fieldTransform =
        Tween<double>(begin: -150.0, end: 0.0).animate(searchField!);
    customIcon();
    _initalCameraPosition = CameraPosition(target: widget.latLng, zoom: 16);

    _currentLocation = Location(
        latitude: widget.latLng.latitude,
        longitude: widget.latLng.longitude,
        timestamp: DateTime.now());
    getCurrentPosition();
    startSetInterval(Duration(seconds: 2), () {
      getCurrentPosition();
    });
  }

  void addNewMarkers() {
    _markers.add(
      Marker(
        markerId: MarkerId('Sydney'),
        position: LatLng(40.22553508682186, 28.914500038523727),
      ),
    );
  }

  void startSetInterval(Duration duration, Function function) {
    /* Timer.periodic(duration, (_) {
      function();
    }); */
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  void customIcon() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(12, 12)), 'assets/pin.png')
        .then((d) {
      bitmapDescriptor = d;
    });
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        isFetchedCurrentLocation = true;
        _initalCameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 16);
      });
      print(position);
      directPosition(position);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> directPosition(Position position) async {
    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 16),
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
    if (mapController == null) {
      return;
    }

    if (position.zoom < 15.5) {
      setState(() {
        _markers = {};
      });
    } else {
      addNewMarkers();
      LatLngBounds visibleRegion = await mapController!.getVisibleRegion();
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
  }

  Widget emptyBody = Container(
    color: AppTheme.background,
    alignment: Alignment.center,
    child: Container(
      width: 75,
      height: 75,
      child: CircularProgressIndicator(
        color: AppTheme.firstColor,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    if (isFetchedCurrentLocation) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onTap: (position) {},
              onCameraMove: (CameraPosition position) {
                _getVisibleRegionCoordinates(position);
              },
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  mapController = controller;
                });
                addNewMarkers();
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
              },
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: _initalCameraPosition,
              tiltGesturesEnabled: false,
              compassEnabled: false,
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
            ),
            fieldSeen
                ? AnimatedBuilder(
                    animation: searchField!,
                    builder: (BuildContext context, Widget? child) {
                      return Opacity(
                        opacity: fieldOpacity!.value,
                        child: Transform.translate(
                          offset: Offset(0, fieldTransform!.value),
                          child: onLoadingField
                              ? Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(
                                      top: getPaddingSreenTopHeight() * 3),
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      color: AppTheme.firstColor,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: fetchNewPlaces,
                                  child: Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(
                                        top: getPaddingSreenTopHeight() * 3),
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: AppTheme.background,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: AppText(text: 'Bu Alanda Ara'),
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  )
                : Container()
          ],
        ),
      );
    } else {
      return emptyBody;
    }
  }
}
