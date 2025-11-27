import 'package:dio/dio.dart';
import 'package:docdoc/logic/all_doctors/all_doctors_event.dart';
import 'package:docdoc/logic/all_doctors/all_doctors_state.dart';
import 'package:docdoc/logic/models/doctor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/core/utils/pref_helper.dart';

class AllDoctorsBloc extends Bloc<AllDoctorsEvent, AllDoctorsState> {
  AllDoctorsBloc() : super(AllDoctorsInitial()) {
    on<FetchAllDoctors>((event, emit) async {
      emit(AllDoctorsLoading());
      try {
        String? token = await PrefHelper.getToken();

        final response = await Dio().get(
          event.cityId != null
              ? "https://vcare.integration25.com/api/doctor/doctor-filter?city=${event.cityId}"
              : "https://vcare.integration25.com/api/doctor/index",
          queryParameters: event.cityId != null ? {"city": event.cityId} : {},
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

        final List data = response.data['data'];
        final doctors = data.map((e) => DoctorModel.fromJson(e)).toList();
        emit(AllDoctorsSuccess(doctors));
      } catch (e) {
        emit(AllDoctorsError(e.toString()));
      }
    });

  }
}

