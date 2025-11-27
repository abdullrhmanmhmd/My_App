import 'package:dio/dio.dart';
import 'package:docdoc/logic/home/home_event.dart';
import 'package:docdoc/logic/home/home_state.dart';
import 'package:docdoc/logic/models/doctor_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/core/utils/pref_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoading());

      try {
        String? token = await PrefHelper.getToken();

        final response = await Dio().get(
          "https://vcare.integration25.com/api/home/index",
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

        final List data = response.data['data']; // ✅ Correct field
        List doctors = [];

        for (var specialization in data) {
          if (specialization['doctors'] != null) {
            doctors.addAll(specialization['doctors']);
          }
        }

        final doctorList =
        doctors.map((json) => DoctorModel.fromJson(json)).toList();

        emit(HomeSuccess(doctorList));
      } on DioException catch (e) {
        print("DioException: ${e.message}");
        emit(HomeError("Failed to fetch data: ${e.message}"));
      } catch (e) {
        print("General Exception: $e");
        emit(HomeError("An error occurred: $e"));
      }
    });
  }
}
