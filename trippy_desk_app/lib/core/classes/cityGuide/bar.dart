import 'package:trippy_desk_app/core/classes/cityGuide/place_categories.dart';
import 'package:trippy_desk_app/core/classes/cityGuide/subclasses/essensial.dart';
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
  MapPlaceCategories? mapPlaceCategories =
      MapPlaceCategories.returnCategory('Bar');
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
      this.mapPlaceCategories,
      required this.menuTypes,
      required this.prosCons,
      required this.comments,
      required this.openingClosingTimes,
      required this.expensiveCount,
      required this.outsideDesk,
      required this.insideDesk});

  /* static Bar? _selectedBar; */

  static Bar _selectedBar = Bar(
      placeName: 'Radyo Pub',
      placeDescription:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      placeLocation: LatLng(40.22553508682186, 28.914500038523727),
      placeListImage: [
        NetworkImage(
            'https://images.pexels.com/photos/1850592/pexels-photo-1850592.jpeg?auto=compress&cs=tinysrgb&w=800'),
        NetworkImage(
            'https://images.pexels.com/photos/946118/pexels-photo-946118.jpeg?auto=compress&cs=tinysrgb&w=800'),
        NetworkImage(
            'https://images.pexels.com/photos/1128259/pexels-photo-1128259.jpeg?auto=compress&cs=tinysrgb&w=800'),
        NetworkImage(
            'https://images.pexels.com/photos/2611816/pexels-photo-2611816.jpeg?auto=compress&cs=tinysrgb&w=800'),
        NetworkImage(
            'https://images.pexels.com/photos/4694309/pexels-photo-4694309.jpeg?auto=compress&cs=tinysrgb&w=800'),
        NetworkImage(
            'https://images.pexels.com/photos/3009803/pexels-photo-3009803.jpeg?auto=compress&cs=tinysrgb&w=800'),
        NetworkImage(
            'https://images.pexels.com/photos/2873701/pexels-photo-2873701.jpeg?auto=compress&cs=tinysrgb&w=800'),
      ],
      thumbNailPhoto: NetworkImage(
          'https://images.pexels.com/photos/1297465/pexels-photo-1297465.jpeg?auto=compress&cs=tinysrgb&w=800'),
      menuTypes: [],
      prosCons: ProsCons(cons: [], pros: []),
      comments: [],
      openingClosingTimes: [],
      expensiveCount: 3,
      outsideDesk: [],
      insideDesk: []);

  static void setSelectedBar(Bar bar) {
    _selectedBar = bar;
  }

  static Bar? returnSelectedBar() {
    return _selectedBar;
  }
}
