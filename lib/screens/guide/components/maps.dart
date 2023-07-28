import 'dart:async';

import 'package:TrippyAlpapp/constants/theme.dart';
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

class _MapsState extends State<Maps> {
  Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;
  GoogleMapController? mapController;

  late CameraPosition _initalCameraPosition;

  LatLng _location = LatLng(0, 0);

  Location? _currentLocation;

  late Location _locationService;

  bool isFetchedCurrentLocation = false;

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();

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

  void dispose() {
    mapController!.dispose();
    super.dispose();
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
              onCameraMove: (position) {},
              onMapCreated: (GoogleMapController controller) async {
                setState(() {
                  mapController = controller;
                });
                rootBundle
                    .loadString('assets/map.json')
                    .then((String mapStyle) {
                  controller.setMapStyle(mapStyle);
                });
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
          ],
        ),
      );
    } else {
      return emptyBody;
    }
  }
}
