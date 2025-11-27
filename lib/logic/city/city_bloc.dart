

import 'package:dio/dio.dart';
import 'package:docdoc/core/network/api_services.dart';
import 'package:docdoc/core/utils/pref_helper.dart';
import 'package:docdoc/logic/city/city_event.dart';
import 'package:docdoc/logic/city/city_state.dart';
import 'package:docdoc/logic/models/city_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial()) {
    on<FetchCitiesEvent>((event, emit) async {
      emit(CityLoading());
      ApiServices apiServices = ApiServices();

      try {
        String? token = await PrefHelper.getToken();
        final response =
        await Dio().get("https://vcare.integration25.com/api/city/index",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        // final response = await apiServices.get("city/index");

        final List data = response.data["data"];

        final cities = data.map((json) => CityModel.fromJson(json)).toList();

        emit(CityLoaded(cities));
      } catch (e) {
        emit(CityError("Failed to load cities: $e"));
      }
    });
  }
}
