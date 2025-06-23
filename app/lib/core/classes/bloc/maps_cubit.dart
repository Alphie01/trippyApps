import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPolylinesCubit extends Cubit<Map<PolylineId, Polyline>> {
  MapsPolylinesCubit() : super({});
  void setState(Map<PolylineId, Polyline> object) => emit(object);

  void clearState() => emit({});
}

class UserPositionCubit extends Cubit<Position?> {
  UserPositionCubit() : super(null);
  void setPosition(Position userPosition) {
    emit(userPosition);
  }
}

class CurrentPlacemarkCubit extends Cubit<Placemark> {
  CurrentPlacemarkCubit() : super(Placemark());

  void setState(Placemark object) => emit(object);

  Future getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks.first;
      emit(place);
    } catch (e) {
      print(e);
    }
  }
}
