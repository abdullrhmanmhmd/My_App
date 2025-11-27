import 'package:docdoc/logic/models/city_model.dart';

abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<CityModel> cities;
  CityLoaded(this.cities);
}

class CityError extends CityState {
  final String message;
  CityError(this.message);
}
