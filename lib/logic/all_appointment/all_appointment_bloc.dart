import 'package:dio/dio.dart';
import 'package:docdoc/logic/all_appointment/all_appointment_event.dart';
import 'package:docdoc/logic/all_appointment/all_appointment_state.dart';
import 'package:docdoc/logic/models/all_appointment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/core/utils/pref_helper.dart';

class AllAppointmentBloc extends Bloc<AllAppointmentEvent, AllAppointmentState> {
  AllAppointmentBloc() : super(AllAppointmentInitial()) {
    on<FetchAllAppointment>((event, emit) async {
      emit(AllAppointmentLoading());

      try {

        String? token = await PrefHelper.getToken();

        final response = await Dio().get(
          "https://vcare.integration25.com/api/appointment/index",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        final List data = response.data['data'];
        final appointments = data.map((json) => AllAppointmentModel.fromJson(json)).toList();
        emit(AllAppointmentSuccess(appointments));
      } on DioException catch (e) {
        print("DioException: ${e.message}");
        emit(AllAppointmentError("Failed to fetch data: ${e.message}"));
      } catch (e) {
        print("General Exception: $e");
        emit(AllAppointmentError("An error occurred: $e"));
      }
    });
  }
}
