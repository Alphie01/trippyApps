import 'package:TrippyAlpapp/core/classes/cityGuide/place_categories.dart';
import 'package:TrippyAlpapp/core/classes/cityGuide/subclasses/essensial.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bar {
  //MapPlaceCategories.returnCategory('Bar')

  final String placeName;
  final String placeDescription;
  final LatLng placeLocation;
  final List<NetworkImage> placeListImage;
  final NetworkImage? placeLogo;
  final NetworkImage thumbNailPhoto;
  MapPlaceCategories? mapPlaceCategories = MapPlaceCategories.returnCategory('Bar');
  BitmapDescriptor marker = BitmapDescriptor.defaultMarker;
  final List<MenuType> menuTypes;
  final ProsCons prosCons;
  final List<Comments> comments;
  final List<WorkingTimes> openingClosingTimes;
  final int expensiveCount;
  final List<Desk> outsideDesk;
  final List<List<Desk>> insideDesk;

  Bar(
      {required this.placeName,
      required this.placeDescription,
      required this.placeLocation,
      required this.placeListImage,
      this.placeLogo,
      required this.thumbNailPhoto,
      required this.mapPlaceCategories,
      required this.menuTypes,
      required this.prosCons,
      required this.comments,

      required this.openingClosingTimes,
      required this.expensiveCount,
      required this.outsideDesk,
      required this.insideDesk});

  static Bar? _selectedBar;

  static void setSelectedBar(Bar bar) {
    _selectedBar = bar;
  }

  static Bar? returnSelectedBar() {
    return _selectedBar;
  }



}
