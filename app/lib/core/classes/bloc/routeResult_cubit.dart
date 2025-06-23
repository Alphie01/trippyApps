import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RouteResultCubit extends Cubit<PolylineResult> {
  RouteResultCubit() : super(PolylineResult());
  void setState(PolylineResult object) => emit(object);

  void clearState() => emit(PolylineResult());
}
