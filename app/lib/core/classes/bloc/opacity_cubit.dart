import 'package:flutter_bloc/flutter_bloc.dart';

class OpacityCubit extends Cubit<double> {
  OpacityCubit() : super(.5);
  void setState(double object) => emit(object);
}
