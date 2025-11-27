import 'package:dio/dio.dart';
import 'package:docdoc/core/utils/pref_helper.dart';
import 'package:docdoc/logic/serach/search_event.dart';
import 'package:docdoc/logic/serach/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/logic/models/doctor_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchDoctorsEvent>((event, emit) async {
      final query = event.query.trim();
      if (query.isEmpty) {
        emit(SearchInitial());
        return;
      }
      emit(SearchLoading());
      try {
        String? token = await PrefHelper.getToken();
        final response = await Dio().get(
          "https://vcare.integration25.com/api/doctor/doctor-search?name=$query",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        final responseData = response.data;
        if (responseData is Map && responseData.containsKey('data')) {
          final List doctorsJson = responseData['data'];
          final doctors = doctorsJson
              .map((json) => DoctorModel.fromJson(json))
              .toList();

          emit(SearchLoaded(doctors));
        } else {
          emit(SearchError("Unexpected response format"));
        }
      } catch (e) {
        emit(SearchError("Failed to fetch results: $e"));
      }
    });
  }
}
