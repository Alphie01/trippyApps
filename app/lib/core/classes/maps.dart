import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:TrippyAlpapp/core/classes/bloc/maps_cubit.dart';
import 'package:TrippyAlpapp/core/classes/bloc/routeResult_cubit.dart';
import 'package:TrippyAlpapp/core/constants/theme.dart';
import 'package:TrippyAlpapp/core/httpRequests/http.dart';
import 'package:TrippyAlpapp/screens/guide/components/istasyon_displayer.dart';

class MapsMarker {
  static Set<Marker> _markerList = {};

  static Set<Marker> markerList() => markerList();

  static List<Istasyon> currentIstasyonList = [];

  static Future<Set<Marker>> createListOfMarker(
      lat, long, BuildContext context) async {
    Map<String, dynamic> data = {
      'get_direction': 'ok',
      'lat': lat,
      'long': long
    };
    Map<dynamic, dynamic> returns =
        await HTTP_Requests.sendPostRequest('directions', data);
    /* List a = await  */

    if (returns['id'] == 0) {
      currentIstasyonList = [];
      return _markerListCreator(returns['returns'], LatLng(lat, long), context);
    }
    return {};
  }

  static Future<Set<Marker>> _markerListCreator(
      List istasyons, LatLng userPosition, BuildContext context) async {
    Set<Marker> markersList = {};
    BitmapDescriptor mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(16, 16)), 'assets/ev_light.png');
    for (var element in istasyons) {
      Istasyon newIstasyon = Istasyon.istasyonCreator(element['istasyon']);
      markersList.add(
        Marker(
          icon: mapMarker,
          markerId: MarkerId(newIstasyon.id),
          position: LatLng(newIstasyon.cordinates.latitude,
              newIstasyon.cordinates.longitude),
          onTap: () => openIdentifier(context, newIstasyon, userPosition),
        ),
      );
      currentIstasyonList.add(newIstasyon);
    }
    return markersList;
  }

  static Future<PolylineResult> createPolylines(
      LatLng userPosition, LatLng istasyonPos) async {
    // Initializing PolylinePoints

    PolylinePoints polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBN6zk-MmhNmlFyP8lk1uOwxkeOM_Rnz9o', // Google Maps API Key
      PointLatLng(userPosition.latitude, userPosition.longitude),
      PointLatLng(istasyonPos.latitude, istasyonPos.longitude),
      travelMode: TravelMode.driving,
    );

    print(result.overviewPolyline);
    return result;
  }

  static Map<PolylineId, Polyline> _polylines(PolylineResult result) {
    List<LatLng> polylineCoordinates = [];

    Map<PolylineId, Polyline> polylines = {};
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    // Defining an ID
    PolylineId id = PolylineId('poly');
    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppTheme.contrastColor1,
      points: polylineCoordinates,
      width: 3,
    );
    // Adding the polyline to the map
    polylines[id] = polyline;
    /* return [polylineCoordinates, polylines]; */
    return polylines;
  }

  static void openIdentifier(
      BuildContext context, Istasyon istasyon, LatLng userPosition) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return IstasyonInfo(
          setRoute: () async {
            PolylineResult object = await createPolylines(
                userPosition,
                LatLng(istasyon.cordinates.latitude,
                    istasyon.cordinates.longitude));
            Map<PolylineId, Polyline> result = _polylines(object);
            Navigator.pop(context);
            print(object);
            context.read<RouteResultCubit>().setState(object);
            context.read<MapsPolylinesCubit>().setState(result);
          },
          istasyon: istasyon,
        );
      },
    );
  }
}

class TurnInfo {
  final LatLng location;
  final String maneuver;

  TurnInfo({required this.location, required this.maneuver});
}

class Istasyon {
  final String id, name, formatedAdress, shortFormattedAddress, doluluk;
  final int allTimeKW, places;
  final double currentKW, price;
  final List<NetworkImage> istasyonNetworkImage;
  final LatLng cordinates;
  final double? comment_rating;

  Istasyon({
    required this.istasyonNetworkImage,
    required this.id,
    required this.name,
    required this.formatedAdress,
    required this.shortFormattedAddress,
    required this.doluluk,
    required this.allTimeKW,
    required this.places,
    required this.currentKW,
    required this.price,
    required this.cordinates,
    this.comment_rating,
  });

  static Istasyon istasyonCreator(Map response) => Istasyon(
        id: '${response['station_id']}',
        name: response['station_displayName'],
        formatedAdress: response['station_formattedAddress'],
        shortFormattedAddress: response['station_shortFormattedAddress'],
        doluluk: response['station_doluluk'],
        allTimeKW: int.parse(response['station_all_time_kw']),
        places: int.parse(response['station_place']),
        currentKW: double.parse(response['station_current_kw']),
        price: double.parse(response['station_price']),
        cordinates: LatLng(double.parse(response['station_latitude']),
            double.parse(response['station_longitude'])),
        istasyonNetworkImage: _initStationImage([]),
        comment_rating: double.parse(response['station_rating']),
      );
  static List<NetworkImage> _initStationImage(List<String> response) {
    List<NetworkImage> images = [];
    if (response.isNotEmpty) {
      for (var element in response) {
        images.add(NetworkImage(element));
      }
    } else {
      images.add(
        NetworkImage(
          'https://dev.elektronikey.com/bitirme/assets/charging.jpg',
        ),
      );
    }
    return images;
  }
}
